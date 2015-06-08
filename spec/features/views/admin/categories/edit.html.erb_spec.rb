require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "admin/categories/edit", type: :view do
  let(:category){FactoryGirl.create :category}
  let(:other_category){stub_model(Category, name: "edit cate", max_question: "20", max_time: "10")}

  before do
    user = create :user, level: :admin
    login_as user, scope: :user    
  end

  describe "edit categories page" do
    before do
      visit edit_admin_category_path category.id
    end

    it {expect(page).to have_selector "h1", text: "Edit category"}
    it {expect(page).to have_selector("input[id=category_name][value='#{category.name}']")}
    it {expect(page).to have_selector("input[id=category_max_question][value='#{category.max_question}']")}
    it {expect(page).to have_selector("input[id=category_max_time][value='#{category.max_time}']")}
    it {expect(page).to have_selector "input[name=commit]"}

    it "update categories" do
      fill_in "category_name", with: other_category.name
      fill_in "category_max_question", with: other_category.max_question
      fill_in "category_max_time", with: other_category.max_time
      find("input[name=commit]").click
      expect(page).to have_selector "div.alert-success"      
    end
  end
end