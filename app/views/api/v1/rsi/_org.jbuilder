# encoding: utf-8
# frozen_string_literal: true

json.id org.id
json.name org.name
json.sid org.sid
json.archetype org.archetype
json.main_activity org.main_activity
json.secondary_activity org.secondary_activity
json.recruiting org.recruiting
json.commitment org.commitment
json.rpg org.rpg
json.exclusive org.exclusive
json.logo org.logo
json.user_ships do
  json.array! org.user_ships, partial: 'api/v1/rsi/org_ships', as: :user_ship
end
