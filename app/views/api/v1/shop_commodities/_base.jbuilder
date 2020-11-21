# frozen_string_literal: true

json.id shop_commodity.id
json.name shop_commodity.commodity_item.name
json.slug shop_commodity.commodity_item.slug
json.store_image shop_commodity.commodity_item.store_image.url
json.store_image_large shop_commodity.commodity_item.store_image.large.url
json.store_image_medium shop_commodity.commodity_item.store_image.medium.url
json.store_image_small shop_commodity.commodity_item.store_image.small.url
json.category shop_commodity.category
json.sub_category shop_commodity.sub_category
json.sub_category_label shop_commodity.sub_category_label
json.description shop_commodity.commodity_item.description
json.price_per_unit shop_commodity.price_per_unit
json.sell_price shop_commodity.sell_price
json.average_sell_price shop_commodity.average_sell_price
json.buy_price shop_commodity.buy_price
json.average_buy_price shop_commodity.average_buy_price
json.rental_price_1_day shop_commodity.rental_price_1_day
json.average_rental_price_1_day shop_commodity.average_rental_price_1_day
json.rental_price_3_days shop_commodity.rental_price_3_days
json.average_rental_price_3_days shop_commodity.average_rental_price_3_days
json.rental_price_7_days shop_commodity.rental_price_7_days
json.average_rental_price_7_days shop_commodity.average_rental_price_7_days
json.rental_price_30_days shop_commodity.rental_price_30_days
json.average_rental_price_30_days shop_commodity.average_rental_price_30_days
json.location_label shop_commodity.location_label
json.confirmed shop_commodity.confirmed
json.commodity_item_type shop_commodity.commodity_item_type
json.commodity_item_id shop_commodity.commodity_item_id
json.shop do
  json.partial! 'api/v1/shops/base', shop: shop_commodity.shop
end
