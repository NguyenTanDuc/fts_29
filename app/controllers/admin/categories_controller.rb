class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_role, only: :index
  before_action :set_category, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t :create_success
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t :update_success
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html
      format.js
    end    
  end

  private
  def category_params
    params.require(:category).permit :name, :max_question, :max_time
  end

  def set_category
    @category = Category.find params[:id]
  end
end
