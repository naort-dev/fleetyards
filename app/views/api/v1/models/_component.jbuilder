# frozen_string_literal: true

json.id component.id
json.name component.name
json.slug component.slug
json.size component.size
json.class component.component_class
json.type component.component_type
json.manufacturer do
  json.partial! 'api/v1/models/manufacturer', manufacturer: component.manufacturer if component.manufacturer.present?
end
json.manufacturer nil if component.manufacturer.blank?
