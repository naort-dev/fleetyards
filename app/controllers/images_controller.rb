class ImagesController < ApplicationController
  before_action :set_active_nav
  before_filter :authenticate_user!, only: []

  def index
    authorize! :index, :images
    @images = Image.enabled.in_gallery
      .order('images.created_at desc')
      .page(params.fetch(:page, nil))
      .per(20)
  end

  private def set_active_nav
    @active_nav = 'images'
  end
end
