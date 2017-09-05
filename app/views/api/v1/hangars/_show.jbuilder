# encoding: utf-8
# frozen_string_literal: true

json.cache! ['v1', user_ship, user_ship.ship] do
  json.id user_ship.id
  json.name user_ship.name
  json.purchased user_ship.purchased
  json.notify user_ship.notify
  json.ship do
    json.partial! 'api/v1/ships/show', ship: user_ship.ship
  end
end
