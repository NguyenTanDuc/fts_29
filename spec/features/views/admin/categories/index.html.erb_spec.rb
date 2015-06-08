require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "admin/categories/index", type: :view do
  let(:category){FactoryGirl.create :category}
  let(:user){create :user, level: :admin}
  
  before do
    login_as user, scope: :user
    30.times do |n|
      FactoryGirl.create :category, name: "category #{n}"
    end
  end

  describe "index categories page" do
    before do
      visit admin_categories_path
    end

    describe "pagination" do
      it {expect(page).to have_selector "div.pagination"}
      it {expect(page).to have_no_selector "tr#cate_21"}
    end

    it {expect(page).to have_selector "h1", text: "Categories"}
    it {expect(page).to render_template partial: "_category"}
    it {expect(page).to have_selector "table"}
    it {expect(page).to have_selector "a[href='/admin/categories/new']"}
  end
 
end
