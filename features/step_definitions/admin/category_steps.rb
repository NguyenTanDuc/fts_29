Given /^An account admin/ do
  admin = FactoryGirl.create :user
  visit new_user_session_path
  fill_in "user_email", with: admin.email
  fill_in "user_password", with: admin.password
  find("input[name=commit]").click
end

Given /^I have some categories below:$/ do |categories|
  Category.create! categories.hashes
end

Given /^I visit admin categories index page/ do
  visit admin_categories_path
end

Then /^I should see 2 categories in a table/ do
  expect(page).to have_selector("tr")
end 

Given /^I visit new category page/ do
  visit new_admin_category_path
end 

Then /^I should see form create new categories/ do
  expect(page).to have_selector "h1", text: "New category"
  expect(page).to have_selector "#category_name"
  expect(page).to have_selector "#category_max_question"
  expect(page).to have_selector "#category_max_time"
end

When /^I fill in the input name: "(.*)", max_question: "(.*)", max_time: "(.*)"/ do |name, max_question, max_time|
  fill_in "category[name]", with: name
  fill_in "category[max_question]", with: max_question
  fill_in "category[max_time]", with: max_time
end

When /^I click on submit button/ do
  find("input[name=commit]").click  
end

Then /^I should see a message "(.*)"/ do |message|
  expect(page).to have_selector "div.alert-success", text: message
end

Then /^I should see a danger message "(.*)"/ do |message|
  expect(page).to have_selector "div.alert-danger", text: message
end

Given /^I visit edit category page with category_id: "(.*)"/ do |category_id|
  visit edit_admin_category_path category_id
end

Then /^I should see form edit category "(.*)"/ do |category_id|
  expect(page).to have_selector "h1", text: "Edit category"
  expect(page).to have_selector "input[id=category_name][value='#{Category.find(category_id).name}']"
  expect(page).to have_selector "input[id=category_max_question][value='#{Category.find(category_id).max_question}']"
  expect(page).to have_selector "input[id=category_max_time][value='#{Category.find(category_id).max_time}']"
end

When /^I change the input name: "(.*)", max_question: "(.*)", max_time: "(.*)"/ do |name, max_question, max_time|
  fill_in "category[name]", with: name
  fill_in "category[max_question]", with: max_question
  fill_in "category[max_time]", with: max_time
end

# When /^I click on "(.*)" link/ do |delete_text|
#  expect {click_link delete_text, match: :first}.to change(Category, :count).by(-1)
# end

# Given /^I have a category need to delete with category_id: "(.*)"/ do |category_id|
#   expect {delete :destroy, id: category_id, format: :js}.to change(Category, :count).by(-1)
# end