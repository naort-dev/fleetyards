# frozen_string_literal: true

require 'discord/ship_on_sale'

class VehiclesWorker
  include Sidekiq::Worker
  sidekiq_options retry: true, queue: (ENV['VEHICLES_QUEUE'] || 'fleetyards_vehicles_loader').to_sym

  def perform(model_id)
    model = Model.find(model_id)

    Discord::ShipOnSale.new(model: model).run

    Vehicle.where(model_id: model_id, sale_notify: true, purchased: false).find_each do |vehicle|
      next unless vehicle.user.sale_notify?

      ActionCable.server.broadcast("on_sale_#{vehicle.user.username}", vehicle.to_json)
      VehicleMailer.on_sale(vehicle).deliver_later
    end
  end
end
