# frozen_string_literal: true

module Api
  module V1
    class FleetsController < ::Api::V1::BaseController
      before_action :authenticate_api_user!, only: %i[my models]

      def index
        authorize! :index, :api_fleets

        @fleets = if current_user.present?
                    Fleet.where.not(id: current_user.fleet_ids).order(name: :asc)
                  else
                    Fleet.all.order(name: :asc)
                  end
      end

      def my
        authorize! :index, :api_my_fleets

        @fleets = current_user.fleets.order(name: :asc)
      end

      def show
        authorize! :show, :api_fleets

        @fleet = Fleet.find_by!(sid: params[:sid])
      end

      def create
        authorize! :create, :api_fleets
        @fleet = Fleet.new(sid: params[:sid])

        return if @fleet.save

        render json: ValidationError.new("fleet.create", @fleet.errors), status: :bad_request
      end

      def members
        authorize! :index, :api_my_fleets

        @members = fleet.members
      end

      def models
        authorize! :index, :api_my_fleets

        search = fleet.models
                      .select(
                        %i[
                          id name slug description length beam height mass cargo size
                          min_crew max_crew scm_speed afterburner_speed store_image store_url
                          price on_sale production_status production_note focus classification
                          focus rsi_id rsi_name rsi_slug manufacturer_id created_at updated_at
                          pitch_max yaw_max roll_max xaxis_acceleration yaxis_acceleration
                          zaxis_acceleration fallback_price
                        ]
                      )
                      .group(:id)
                      .ransack(query_params)

        search.sorts = 'name asc' if search.sorts.empty?

        result = search.result.offset(params[:offset]).limit(params[:limit])

        @models = result.map do |model|
          OpenStruct.new(
            count: fleet.models.where(id: model.id).count,
            model: model
          )
        end
      end

      def count
        authorize! :index, :api_my_fleets

        @count = OpenStruct.new(
          total: fleet.models.count,
          classifications: fleet.models.map(&:classification).uniq.compact.map do |classification|
            OpenStruct.new(
              count: fleet.models.where(classification: classification).count,
              name: classification,
              label: classification.humanize
            )
          end
        )
      end

      private def fleet
        @fleet = current_user.fleets.find_by!(sid: params[:sid])
      end
    end
  end
end
