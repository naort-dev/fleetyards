# encoding: utf-8
# frozen_string_literal: true

module Resolvers
  module Vehicles
    class List < Resolvers::Base
      def resolve
        search = current_user.user_ships.ransack(args[:q].to_h)

        result = search.result
                       .offset(args[:offset])

        result = result.limit(limit) if limit.present?

        result
      end

      private def limit
        return if username.blank?

        [(args[:limit] || 30), 100].min
      end

      private def username
        args[:username] && args[:username].downcase
      end
    end
  end
end
