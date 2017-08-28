# frozen_string_literal: true

module Admin
  class ShipsController < BaseController
    before_action :set_active_nav

    def index
      authorize! :index, :admin_ships
      @ships = Ship.all
                   .order(sort_column + " " + sort_direction)
                   .page(params.fetch(:page) { nil })
                   .per(15)
    end

    def new
      authorize! :create, :admin_ships
      @ship = Ship.new
    end

    def create
      authorize! :create, :admin_ships
      @ship = Ship.new(ship_params)
      if ship.save
        redirect_to admin_ships_path, notice: I18n.t(:"messages.create.success", resource: I18n.t(:"resources.ship"))
      else
        render 'new', error: I18n.t(:"messages.create.failure", resource: I18n.t(:"resources.ship"))
      end
    end

    def edit
      authorize! :update, ship
      ship.build_addition if ship.addition.blank?
    end

    def update
      authorize! :update, ship
      if ship.update(ship_params)
        redirect_to admin_ships_path, notice: I18n.t(:"messages.update.success", resource: I18n.t(:"resources.ship"))
      else
        render "edit", error: I18n.t(:"messages.update.failure", resource: I18n.t(:"resources.ship"))
      end
    end

    def destroy
      authorize! :destroy, ship
      if ship.destroy
        redirect_to admin_ships_path, notice: I18n.t(:"messages.destroy.success", resource: I18n.t(:"resources.ship"))
      else
        redirect_to admin_ships_path, error: I18n.t(:"messages..destroy.failure", resource: I18n.t(:"resources.ship"))
      end
    end

    def gallery
      authorize! :gallery, :admin_ships
      respond_to do |format|
        format.js do
          images = ship.images.order('created_at desc').all
          jq_images = images.collect(&:to_jq_upload)
          render json: { files: jq_images }.to_json
        end
        format.html do
          # render upload form
        end
      end
    end

    def reload
      authorize! :reload, :admin_ships
      respond_to do |format|
        format.js do
          ShipsWorker.perform_async
          render json: true
        end
        format.html do
          redirect_to root_path
        end
      end
    end

    def reload_one
      authorize! :reload, :admin_ships
      respond_to do |format|
        format.js do
          ShipWorker.perform_async(ship.name)
          render json: true
        end
        format.html do
          redirect_to root_path
        end
      end
    end

    def toggle
      authorize! :toggle, ship

      respond_to do |format|
        format.js do
          if ship.update(ship_params)
            message = I18n.t(:"messages.disabled.success", resource: I18n.t(:"resources.ship"))
            if ship.enabled?
              message = I18n.t(:"messages.enabled.success", resource: I18n.t(:"resources.ship"))
            end
            render json: { message: message }
          else
            render json: false, status: :bad_request
          end
        end
        format.html do
          redirect_to admin_ships_path
        end
      end
    end

    private def ship_params
      @ship_params ||= params.require(:ship).permit(
        :name, :enabled, :store_image, :store_image_cache, :remove_store_image,
        addition_attributes: %i[
          id beam length height mass cargo net_cargo crew _destroy
        ]
      )
    end

    private def sort_column
      Ship.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    helper_method :sort_column

    private def ship
      @ship ||= Ship.where(id: params.fetch(:id, nil)).first
    end
    helper_method :ship

    private def set_active_nav
      @active_nav = 'admin-ships'
    end
  end
end
