# frozen_string_literal: true

hurston = CelestialObject.find_or_create_by!(name: 'Hurston')
hurston.update!(store_image: Rails.root.join('db/seeds/images/stanton/hurston/hurston.png').open, hidden: false)

teasa_spaceport = Station.find_or_initialize_by(name: 'Teasa Spaceport')
teasa_spaceport.update!(celestial_object: hurston, station_type: :spaceport, location: 'Lorville', store_image: Rails.root.join('db/seeds/images/stanton/hurston/teasa_spaceport.jpg').open, hidden: false)
teasa_spaceport.docks.destroy_all
pad = 1
{ large: 6, extra_large: 2 }.each do |ship_size, count|
  count.times do
    teasa_spaceport.docks << Dock.new(
      name: "Hangar #{"%02d" % pad}",
      dock_type: :hangar,
      ship_size: ship_size,
    )
    pad += 1
  end
end

teasa_spaceport.habitations.destroy_all
%w[1 2 3 4 5 6].each do |level|
  [['C', 6], ['B', 4]].each do |prefix|
    pad = 1
    { small_apartment: prefix[1] }.each do |apartment_size, count|
      count.times do
        teasa_spaceport.habitations << Habitation.new(
          name: "L19 Habitations - Level #{level} Apartment #{prefix[0]}#{"%02d" % pad}",
          habitation_type: apartment_size
        )
        pad += 1
      end
    end
  end
end

new_deal = Shop.find_or_initialize_by(name: 'New Deal', station: teasa_spaceport)
new_deal.update!(shop_type: :ships, store_image: Rails.root.join('db/seeds/images/stanton/hurston/new_deal.png').open, selling: true, hidden: false)

l19 = Station.find_or_initialize_by(name: 'L19 District')
l19.update!(celestial_object: hurston, station_type: :district, location: 'Lorville', store_image: Rails.root.join('db/seeds/images/stanton/hurston/l19.jpg').open, hidden: false)

admin = Shop.find_or_initialize_by(name: 'Admin', station: l19)
admin.update!(shop_type: :admin)
tammany_and_sons = Shop.find_or_initialize_by(name: 'Tammany and Sons', station: l19)
tammany_and_sons.update!(shop_type: :superstore, store_image: Rails.root.join('db/seeds/images/stanton/hurston/tammany_and_sons.jpg').open, hidden: false)
reclamation_n_disposal = Shop.find_or_initialize_by(name: 'Reclamation & Disposal', station: l19)
reclamation_n_disposal.update!(shop_type: :salvage, store_image: Rails.root.join('db/seeds/images/stanton/hurston/reclamation_n_disposal.jpg').open, hidden: false)
m_n_v = Shop.find_or_initialize_by(name: 'M & V', station: l19)
m_n_v.update!(shop_type: :bar, store_image: Rails.root.join('db/seeds/images/stanton/hurston/m_n_v.jpg').open, hidden: false)
maria_pure_of_heart = Shop.find_or_initialize_by(name: 'MARIA - Pure of Heart', station: l19)
maria_pure_of_heart.update!(shop_type: :hospital, store_image: Rails.root.join('db/seeds/images/stanton/hurston/maria_pure_of_heart.jpg').open, hidden: false)


stanhope = Station.find_or_initialize_by(name: 'HDMS-Stanhope')
stanhope.update!(celestial_object: hurston, station_type: :outpost, location: 'Hurston', hidden: false)
admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: stanhope)
admin_office.update!(shop_type: :admin, hidden: false)

edmond = Station.find_or_initialize_by(name: 'HDMS-Edmond')
edmond.update!(celestial_object: hurston, station_type: :outpost, location: 'Hurston', hidden: false)
admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: edmond)
admin_office.update!(shop_type: :admin, hidden: false)

hadley = Station.find_or_initialize_by(name: 'HDMS-Hadley')
hadley.update!(celestial_object: hurston, station_type: :outpost, location: 'Hurston', hidden: false)
admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: hadley)
admin_office.update!(shop_type: :admin, hidden: false)

oparei = Station.find_or_initialize_by(name: 'HDMS-Oparei')
oparei.update!(celestial_object: hurston, station_type: :outpost, location: 'Hurston', hidden: false)
admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: oparei)
admin_office.update!(shop_type: :admin, hidden: false)

pinewood = Station.find_or_initialize_by(name: 'HDMS-Pinewood')
pinewood.update!(celestial_object: hurston, station_type: :outpost, location: 'Hurston', hidden: false)
admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: pinewood)
admin_office.update!(shop_type: :admin, hidden: false)

thedus = Station.find_or_initialize_by(name: 'HDMS-Thedus')
thedus.update!(celestial_object: hurston, station_type: :outpost, location: 'Hurston', hidden: false)
admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: thedus)
admin_office.update!(shop_type: :admin, hidden: false)

r_n_r_hur_l1 = Station.find_or_initialize_by(name: 'Rest & Relax (HUR-L1)')
r_n_r_hur_l1.update!(celestial_object: hurston, station_type: :rest_stop, location: 'HUR-L1', store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l1/hur_l1.jpg').open, hidden: false)

r_n_r_hur_l1.docks.destroy_all
pad = 1
{ medium: 3, large: 1 }.each do |ship_size, count|
  count.times do |index|
    r_n_r_hur_l1.docks << Dock.new(
      name: "Ladingpad #{"%02d" % pad}",
      dock_type: :landingpad,
      ship_size: ship_size,
    )
    pad += 1
  end
end
pad = 1
{ large: 2 }.each do |ship_size, count|
  count.times do |index|
    r_n_r_hur_l1.docks << Dock.new(
      name: "Hangar #{"%02d" % pad}",
      dock_type: :hangar,
      ship_size: ship_size,
    )
    pad += 1
  end
end

admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: r_n_r_hur_l1)
admin_office.update!(shop_type: :admin, store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l1/admin.jpg').open, hidden: false)
live_fire_weapons = Shop.find_or_initialize_by(name: 'Livefire Weapons', station: r_n_r_hur_l1)
live_fire_weapons.update!(shop_type: :weapons, store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l1/weapons.jpg').open, hidden: false)
casaba = Shop.find_or_initialize_by(name: 'Casaba Outlet', station: r_n_r_hur_l1)
casaba.update!(shop_type: :clothing, store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l1/casaba.jpg').open, hidden: false)
platinum_bay = Shop.find_or_initialize_by(name: 'Platinum Bay', station: r_n_r_hur_l1)
platinum_bay.update!(shop_type: :components, store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l1/platinum.jpg').open, hidden: false)

r_n_r_hur_l2 = Station.find_or_initialize_by(name: 'Rest & Relax (HUR-L2)')
r_n_r_hur_l2.update!(celestial_object: hurston, station_type: :rest_stop, location: 'HUR-L2', hidden: false)

admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: r_n_r_hur_l2)
admin_office.update!(shop_type: :admin, hidden: false)
live_fire_weapons = Shop.find_or_initialize_by(name: 'Livefire Weapons', station: r_n_r_hur_l2)
live_fire_weapons.update!(shop_type: :weapons, hidden: false)
casaba = Shop.find_or_initialize_by(name: 'Casaba Outlet', station: r_n_r_hur_l2)
casaba.update!(shop_type: :clothing, hidden: false)
platinum_bay = Shop.find_or_initialize_by(name: 'Platinum Bay', station: r_n_r_hur_l2)
platinum_bay.update!(shop_type: :components, hidden: false)

r_n_r_hur_l3 = Station.find_or_initialize_by(name: 'Rest & Relax (HUR-L3)')
r_n_r_hur_l3.update!(celestial_object: hurston, station_type: :rest_stop, location: 'HUR-L3', hidden: false)

admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: r_n_r_hur_l3)
admin_office.update!(shop_type: :admin, hidden: false)
live_fire_weapons = Shop.find_or_initialize_by(name: 'Livefire Weapons', station: r_n_r_hur_l3)
live_fire_weapons.update!(shop_type: :weapons, hidden: false)
casaba = Shop.find_or_initialize_by(name: 'Casaba Outlet', station: r_n_r_hur_l3)
casaba.update!(shop_type: :clothing, hidden: false)
platinum_bay = Shop.find_or_initialize_by(name: 'Platinum Bay', station: r_n_r_hur_l3)
platinum_bay.update!(shop_type: :components, hidden: false)

r_n_r_hur_l4 = Station.find_or_initialize_by(name: 'Rest & Relax (HUR-L4)')
r_n_r_hur_l4.update!(celestial_object: hurston, station_type: :rest_stop, location: 'HUR-L4', store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l4/hur_l4.jpg').open, hidden: false)

r_n_r_hur_l4.docks.destroy_all
pad = 1
{ medium: 1, large: 3 }.each do |ship_size, count|
  count.times do |index|
    r_n_r_hur_l4.docks << Dock.new(
      name: "Ladingpad #{"%02d" % pad}",
      dock_type: :landingpad,
      ship_size: ship_size,
    )
    pad += 1
  end
end
pad = 1
{ large: 2 }.each do |ship_size, count|
  count.times do |index|
    r_n_r_hur_l4.docks << Dock.new(
      name: "Hangar #{"%02d" % pad}",
      dock_type: :hangar,
      ship_size: ship_size,
    )
    pad += 1
  end
end

admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: r_n_r_hur_l4)
admin_office.update!(shop_type: :admin, hidden: false)
live_fire_weapons = Shop.find_or_initialize_by(name: 'Livefire Weapons', station: r_n_r_hur_l4)
live_fire_weapons.update!(shop_type: :weapons, hidden: false)
casaba = Shop.find_or_initialize_by(name: 'Casaba Outlet', station: r_n_r_hur_l4)
casaba.update!(shop_type: :clothing, hidden: false)
platinum_bay = Shop.find_or_initialize_by(name: 'Platinum Bay', station: r_n_r_hur_l4)
platinum_bay.update!(shop_type: :components, hidden: false)

r_n_r_hur_l5 = Station.find_or_initialize_by(name: 'Rest & Relax (HUR-L5)')
r_n_r_hur_l5.update!(celestial_object: hurston, station_type: :rest_stop, location: 'HUR-L5', store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l5/hur_l5.jpg').open, hidden: false)

r_n_r_hur_l5.docks.destroy_all
pad = 1
{ medium: 3, large: 1 }.each do |ship_size, count|
  count.times do |index|
    r_n_r_hur_l5.docks << Dock.new(
      name: "Ladingpad #{"%02d" % pad}",
      dock_type: :landingpad,
      ship_size: ship_size,
    )
    pad += 1
  end
end
pad = 1
{ large: 2 }.each do |ship_size, count|
  count.times do |index|
    r_n_r_hur_l5.docks << Dock.new(
      name: "Hangar #{"%02d" % pad}",
      dock_type: :hangar,
      ship_size: ship_size,
    )
    pad += 1
  end
end

admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: r_n_r_hur_l5)
admin_office.update!(shop_type: :admin, store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l5/admin.jpg').open, hidden: false)
live_fire_weapons = Shop.find_or_initialize_by(name: 'Livefire Weapons', station: r_n_r_hur_l5)
live_fire_weapons.update!(shop_type: :weapons, store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l5/weapons.jpg').open, hidden: false)
casaba = Shop.find_or_initialize_by(name: 'Casaba Outlet', station: r_n_r_hur_l5)
casaba.update!(shop_type: :clothing, store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l5/casaba.jpg').open, hidden: false)
platinum_bay = Shop.find_or_initialize_by(name: 'Platinum Bay', station: r_n_r_hur_l5)
platinum_bay.update!(shop_type: :components, store_image: Rails.root.join('db/seeds/images/stanton/hurston/hur_l5/platinum.jpg').open, hidden: false)


