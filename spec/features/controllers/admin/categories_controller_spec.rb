require 'rails_helper'
require 'shared_contexts'
require 'shared_examples'

RSpec.describe Admin::CategoriesController, type: :controller do
  render_views
  let(:category){create :category}
  let(:user){create :user, level: :admin}
  let(:other_category){stub_model(Category, name: "edit cate", max_question: "20", max_time: "10")}

  describe "without sign in" do
    include_examples "GET index without permission"
    include_examples "GET new without permission"
    it "GET edit without permission" do
      get :edit, id: category.id
      is_expected.to redirect_to(root_url)
    end
  end

  describe "signed in" do
    before do
      @category = category
      sign_in user
      login_as user, scope: :user
    end

    include_examples "GET index with permission"
    include_examples "GET new with permission"
    it "GET edit with permission" do
      get :edit, id: category.id
      expect(response).to render_template :edit
    end

    describe "POST create" do 
      it{expect {post :create, category: {name: other_category.name, max_question: other_category.max_question, 
                                          max_time: other_category.max_time}}.to change(Category, :count).by(1)}
    end

    describe "PUT update" do
      before do
        put :update, id: category.id, category: {name: other_category.name, max_question: other_category.max_question, 
                                                 max_time: other_category.max_time}
        category.reload
      end

      it {expect(page).to redirect_to(admin_categories_path)}
      it {expect(category.name).to eql other_category[:name]}
      it {expect(category.max_question).to eql other_category[:max_question]}
      it {expect(category.max_time).to eql other_category[:max_time]}      
    end

    describe "DELETE destroy" do
      it {expect{delete :destroy, id: category.id, format: :js}.to change(Category, :count).by(-1)}
    end
  end   
end