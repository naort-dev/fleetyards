# frozen_string_literal: true

json.cache! ['v1', user] do
  json.id user.id
  json.email user.email
  json.username user.username
  json.avatar user.avatar.small.url
  json.rsi_handle user.rsi_handle
  json.discord user.discord
  json.youtube user.youtube
  json.twitch user.twitch
  json.homepage user.homepage
  json.is_admin user.admin?
  json.sale_notify user.sale_notify
  json.public_hangar user.public_hangar
  json.fleets do
    json.array! user.fleets.not_declined, partial: 'api/v1/users/fleet', as: :fleet
  end
  json.partial! 'api/shared/dates', record: user
end
