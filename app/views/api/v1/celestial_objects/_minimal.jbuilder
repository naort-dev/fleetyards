# frozen_string_literal: true

json.cache! ['v1', celestial_object] do
  json.partial! 'api/v1/celestial_objects/base', celestial_object: celestial_object
  json.moons do
    json.array! celestial_object.moons.order(designation: :asc).visible.order(:name), partial: 'api/v1/celestial_objects/base', as: :celestial_object
  end
  json.starsystem do
    json.partial! 'api/v1/starsystems/base', starsystem: celestial_object.starsystem
  end
  json.partial! 'api/shared/dates', record: celestial_object
end
