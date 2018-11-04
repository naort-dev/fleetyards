# frozen_string_literal: true

class Component < ApplicationRecord
  include SlugHelper

  belongs_to :manufacturer, required: false
  has_many :shop_commodities, as: :commodity_item, dependent: :destroy

  validates :name, presence: true

  before_save :update_slugs
  after_save :touch_shop_commodities

  mount_uploader :store_image, StoreImageUploader

  def self.ordered_by_name
    order(name: :asc)
  end

  enum item_class: %i[stealth civilian industrial military]
  ransacker :item_class, formatter: proc { |v| Component.item_classes[v] } do |parent|
    parent.table[:item_class]
  end

  def self.item_types
    %w[
      weapons
      turrets
      shield_generators
      missiles
      coolers
      power_plants
      quantum_drives
    ]
  end

  def self.component_classes
    %w[
      RSIModular
      RSIWeapon
      RSIAvionic
      RSIPropulsion
      RSIThruster
    ]
  end

  def self.class_filters
    Component.all.map(&:component_class).uniq.compact.map do |item|
      Filter.new(
        category: 'class',
        name: I18n.t("filter.component.class.items.#{item.downcase}"),
        value: item
      )
    end
  end

  def component_class_label
    I18n.t("filter.component.class.items.#{component_class.downcase}")
  end

  private def touch_shop_commodities
    # rubocop:disable Rails/SkipsModelValidations
    shop_commodities.update_all(updated_at: Time.zone.now)
    # rubocop:enable Rails/SkipsModelValidations
  end

  private def update_slugs
    self.slug = SlugHelper.generate_slug(name)
  end
end
