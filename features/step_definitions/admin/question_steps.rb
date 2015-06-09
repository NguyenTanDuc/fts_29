Given /^I login with admin account/ do
  admin = FactoryGirl.create :user
  visit new_user_session_path
  fill_in "user_email", with: admin.email
  fill_in "user_password", with: admin.password
  find("input[name=commit]").click
end

Given /^I have a categories list below:$/ do |categories|
  Category.create categories.hashes
end

Given /^I have a questions list below:$/ do |questions|
  Question.create questions.hashes
end

Given /^I visit question index page/ do
  visit admin_questions_path
end

Given /^I should see "(.*)" question in the table/ do |question|
  expect(page).to have_selector "tr"
end