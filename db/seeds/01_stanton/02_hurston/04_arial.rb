# frozen_string_literal: true

arial = CelestialObject.find_or_create_by!(name: 'Arial')
arial.update!(store_image: Rails.root.join('db/seeds/images/stanton/hurston/arial/arial.jpg').open, hidden: false)

lathan = Station.find_or_initialize_by(name: 'HDMS-Lathan')
lathan.update!(celestial_object: arial, station_type: :outpost, location: 'Arial', store_image: Rails.root.join('db/seeds/images/stanton/hurston/arial/lathan.jpg').open, hidden: false)
admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: lathan)
admin_office.update!(shop_type: :admin, store_image: Rails.root.join('db/seeds/images/stanton/hurston/arial/lathan_admin.jpg').open, hidden: false)

lathan.docks.destroy_all
pad = 1
{ small: 2 }.each do |ship_size, count|
  count.times do
    lathan.docks << Dock.new(
      name: ("%02d" % pad),
      dock_type: :vehiclepad,
      ship_size: ship_size,
    )
    pad += 1
  end
end
pad = 1
{ medium: 1, large: 1 }.each do |ship_size, count|
  count.times do |index|
    lathan.docks << Dock.new(
      name: ("%02d" % pad),
      dock_type: :landingpad,
      ship_size: ship_size,
    )
    pad += 1
  end
end

bezdek = Station.find_or_initialize_by(name: 'HDMS-Bezdek')
bezdek.update!(celestial_object: arial, station_type: :outpost, location: 'Arial', store_image: Rails.root.join('db/seeds/images/stanton/hurston/arial/bezdek.jpg').open, hidden: false)
admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: bezdek)
admin_office.update!(shop_type: :admin, store_image: Rails.root.join('db/seeds/images/stanton/hurston/arial/bezdek_admin.jpg').open, hidden: false)

bezdek.docks.destroy_all
pad = 1
{ small: 2 }.each do |ship_size, count|
  count.times do
    bezdek.docks << Dock.new(
      name: ("%02d" % pad),
      dock_type: :vehiclepad,
      ship_size: ship_size,
    )
    pad += 1
  end
end
pad = 1
{ medium: 1, large: 1 }.each do |ship_size, count|
  count.times do |index|
    bezdek.docks << Dock.new(
      name: ("%02d" % pad),
      dock_type: :landingpad,
      ship_size: ship_size,
    )
    pad += 1
  end
end