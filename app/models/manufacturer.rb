class Manufacturer < ActiveRecord::Base
  default_scope ->{ order(name: :asc) }
  translates :description

  include SlugHelper

  mount_uploader :logo, LogoUploader

  has_many :ships

  before_save :update_slugs

  private def update_slugs
    self.slug = SlugHelper::generate_slug self.name
  end
end
