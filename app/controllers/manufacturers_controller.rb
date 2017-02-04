# frozen_string_literal: true
class ManufacturersController < ApplicationController
  before_action :set_active_nav

  skip_authorization_check
  before_action :authenticate_user!, only: []

  def index
    authorize! :index, :manufacturers
    @manufacturers = Manufacturer
                     .enabled
                     .order('manufacturers.name desc')
                     .page(params.fetch(:page, nil))
                     .per(20)
  end

  def show
    authorize! :show, manufacturer

    return unless manufacturer.nil?

    redirect_to manufacturers_path, alert: I18n.t(:"messages.record_not_found")
  end

  private def manufacturer
    @manufacturer ||= Manufacturer.enabled.where(slug: params.fetch(:slug, nil)).first
  end
  helper_method :manufacturer

  private def set_active_nav
    @active_nav = 'manufacturers'
  end
end
