# encoding: utf-8
# frozen_string_literal: true

module Resolvers
  module UserVehicle
    class Update < Resolvers::Base
      def resolve
        user_ship = UserShip.find(args[:user_vehicle_id])

        if user_ship.update(args[:data])
          ActionCable.server.broadcast("updates_hangar_#{current_user.username}", user_ship.to_builder.target!)
        else
          add_active_record_errors(user_ship)
        end

        user_ship
      end
    end
  end
end
