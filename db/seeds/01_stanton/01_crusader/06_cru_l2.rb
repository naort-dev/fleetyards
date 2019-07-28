# frozen_string_literal: true

crusader = CelestialObject.find_or_create_by!(name: 'Crusader')

hidden = true # currently not present 2019-07-28

cru_l2 = Station.find_or_initialize_by(name: 'Rest & Relax (CRU-L2)')
cru_l2.update!(
  celestial_object: crusader,
  station_type: :rest_stop,
  location: 'CRU-L2',
  # store_image: Rails.root.join('db/seeds/images/stanton/crusader/cru-l2/cru-l2.jpg').open,
  hidden: hidden
)

admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: cru_l2)
admin_office.update!(
  shop_type: :admin,
  # store_image: Rails.root.join('db/seeds/images/stanton/crusader/cru-l2/admin.jpg').open,
  hidden: hidden
)

live_fire_weapons = Shop.find_or_initialize_by(name: 'Livefire Weapons', station: cru_l2)
live_fire_weapons.update!(
  shop_type: :weapons,
  # store_image: Rails.root.join('db/seeds/images/stanton/crusader/cru-l2/weapons.jpg').open,
  hidden: hidden
)

casaba = Shop.find_or_initialize_by(name: 'Casaba Outlet', station: cru_l2)
casaba.update!(
  shop_type: :clothing,
  # store_image: Rails.root.join('db/seeds/images/stanton/crusader/cru-l2/casaba.jpg').open,
  hidden: hidden
)

platinum_bay = Shop.find_or_initialize_by(name: 'Platinum Bay', station: cru_l2)
platinum_bay.update!(
  shop_type: :components,
  # store_image: Rails.root.join('db/seeds/images/stanton/crusader/cru-l2/platinum_bay.jpg').open,
  hidden: hidden
)

# cru_l2.docks.destroy_all
# { small: [1, 3], large: [2, 4]}.each do |ship_size, pads|
#   pads.each do |pad|
#     cru_l2.docks << Dock.new(
#       name: "Landingpad #{"%02d" % pad}",
#       dock_type: :landingpad,
#       ship_size: ship_size,
#     )
#   end
# end
# { large: [1, 2, 3, 4]}.each do |ship_size, hangars|
#   hangars.each do |hangar|
#     cru_l2.docks << Dock.new(
#       name: "Hangar #{"%02d" % hangar}",
#       dock_type: :hangar,
#       ship_size: ship_size,
#     )
#   end
# end
