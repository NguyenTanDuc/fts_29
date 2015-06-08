require 'rails_helper'
# require 'shared_contexts'
require 'shared_examples'

RSpec.describe Admin::QuestionsController, type: :controller do
  render_views
  let(:question){create(:question)}
  describe "without signin" do
    include_examples "GET index without permission"
    include_examples "GET new without permission"
    it "GET edit without permission" do
      get :edit, id: question.id
      is_expected.to redirect_to(root_url)
    end
  end

  describe "signed in" do
    before do
      user = create :user, level: :admin
      sign_in user
      login_as user, scope: :user
      4.times {create :answer, question_id: question.id}
    end

    describe "GET index" do
      it "render index" do
        visit admin_questions_path
        expect(response).to render_template :index
      end
    end   

    describe "GET new" do
      it "render new" do
        visit new_admin_question_path
        expect(response).to render_template :new
      end
    end

    describe "GET edit" do
      it "render edit" do
        visit edit_admin_question_path question.id
        expect(response).to render_template :edit
      end
    end

    describe "POST create" do
      it "create new question" do
        visit new_admin_question_path
        fill_in "question_content", with: "new question"
        fill_in "question_answers_attributes_0_content", with: "answer 1"
        fill_in "question_answers_attributes_1_content", with: "answer 2"
        fill_in "question_answers_attributes_2_content", with: "answer 3"
        fill_in "question_answers_attributes_3_content", with: "answer 4"
        find("input[name=btn_submit]").click
        expect(page).to have_selector "div.alert-success"
      end
    end

    describe "PATCH update" do
      it "create new question" do
        visit edit_admin_question_path question.id
        fill_in "question_content", with: "new question"
        fill_in "question_answers_attributes_0_content", with: "answer 1"
        fill_in "question_answers_attributes_1_content", with: "answer 2"
        fill_in "question_answers_attributes_2_content", with: "answer 3"
        fill_in "question_answers_attributes_3_content", with: "answer 4"
        find("input[name=btn_submit]").click
        expect(page).to have_selector "div.alert-success"
      end
    end

    describe "DELETE destroy" do
      it "delete question" do
        visit admin_questions_path
        expect {delete :destroy, id: question.id}.to change(Question, :count).by(-1)
      end
    end
  end
end