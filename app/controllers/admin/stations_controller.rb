# frozen_string_literal: true

module Admin
  class StationsController < BaseController
    before_action :set_active_nav
    after_action :save_filters, only: [:index]

    def index
      authorize! :index, :admin_stations
      @q = Station.ransack(params[:q])

      @q.sorts = 'name asc' if @q.sorts.empty?

      @stations = @q.result
                    .page(params.fetch(:page) { nil })
                    .per(40)
    end

    def new
      authorize! :create, :admin_stations
      @station = Station.new
    end

    def create
      authorize! :create, :admin_stations
      @station = Station.new(station_params)
      if station.save
        redirect_to admin_stations_path(params: index_back_params, anchor: station.id), notice: I18n.t(:"messages.create.success", resource: I18n.t(:"resources.station"))
      else
        render 'new', error: I18n.t(:"messages.create.failure", resource: I18n.t(:"resources.station"))
      end
    end

    def edit
      authorize! :update, station
    end

    def update
      authorize! :update, station
      if station.update(station_params)
        redirect_to admin_stations_path(params: index_back_params, anchor: station.id), notice: I18n.t(:"messages.update.success", resource: I18n.t(:"resources.station"))
      else
        render "edit", error: I18n.t(:"messages.update.failure", resource: I18n.t(:"resources.station"))
      end
    end

    def destroy
      authorize! :destroy, station
      if station.destroy
        redirect_to admin_stations_path(params: index_back_params, anchor: station.id), notice: I18n.t(:"messages.destroy.success", resource: I18n.t(:"resources.station"))
      else
        redirect_to admin_stations_path(params: index_back_params, anchor: station.id), error: I18n.t(:"messages..destroy.failure", resource: I18n.t(:"resources.station"))
      end
    end

    def gallery
      authorize! :gallery, :admin_stations
      respond_to do |format|
        format.js do
          images = station.images.order('created_at desc').all
          jq_images = images.collect(&:to_jq_upload)
          render json: { files: jq_images }.to_json
        end
        format.html do
          # render upload form
        end
      end
    end

    private def station_params
      @station_params ||= params.require(:station).permit(
        :name, :station_type, :hidden, :store_image, :store_image_cache, :remove_store_image,
        :planet_id,
        docks_attributes: %i[
          id dock_type name min_ship_size max_ship_size _destroy
        ], station_shops_attributes: %i[
          id shop_id _destroy
        ]
      )
    end

    private def save_filters
      session[:stations_filters] = params[:q]
      session[:stations_page] = params[:page]
    end

    private def index_back_params
      @index_back_params ||= ActionController::Parameters.new(
        q: session[:stations_filters],
        page: session[:stations_page]
      ).permit!.delete_if { |_k, v| v.nil? }
    end
    helper_method :index_back_params

    private def station
      @station ||= Station.where(id: params.fetch(:id, nil)).first
    end
    helper_method :station

    private def set_active_nav
      @active_nav = 'admin-stations'
    end
  end
end
