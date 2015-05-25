class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  
  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.per_page
  end
end
