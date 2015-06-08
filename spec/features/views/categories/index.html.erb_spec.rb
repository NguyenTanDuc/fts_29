require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "categories/index", type: :view do
  before do
    30.times do |n|
      FactoryGirl.create :category, name: "category #{n}"
    end
    @categories = Category.paginate page: params[:page], per_page: Settings.per_page
    render
  end
  it "render partial" do
    expect(view).to render_template partial: "_category"
  end
end
