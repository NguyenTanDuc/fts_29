require 'rails_helper'
require 'shared_contexts'

RSpec.describe CategoriesController, type: :controller do
  # include_context "signed in"
  # describe "GET index" do
  #   it "has a 200 status code" do
  #     get :index
  #     expect(response.status).to eq 200
  #   end

  #   it "render the index" do
  #     get :index
  #     expect(response).to render_template :index
  #   end
  # end

  # describe "GET index" do
  #   it "render index page" do
  #     user = FactoryGirl.create(:user, level: :normal)
  #     login_as(user, :scope => :user)
  #     visit "/admin/categories"
  #     binding.pry
  #   end
  # end
end
