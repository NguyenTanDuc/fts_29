require 'rails_helper'
require 'shared_examples'

RSpec.describe ExamsController, type: :controller do
  render_views
  let(:user){create :user, level: :admin}
  let(:category){create :category}
  let(:exam){create :exam,category_id: category.id, user_id: user.id}


  describe "without sign in" do
    include_examples "GET index without permission"
    it "GET edit without permission" do
      get :edit, id: exam.id
      is_expected.to redirect_to(root_url)
    end
  end

  describe "signed in" do
    before do
      sign_in user
      login_as user, scope: :user
    end

    include_examples "GET index with permission"
    it "GET edit with permission" do
      get :edit, id: exam.id
      expect(response).to render_template :edit
    end

    describe "POST create" do 
      it{expect {post :create, exam: {category_id: category.id, status: :created, user_id: user.id}}.to change(Exam, :count).by(1)}
    end
  end
end
