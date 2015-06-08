require 'rails_helper'

describe User, type: :model do
  it "Create new user" do
    user = create(:user)
    expect(User.last).to eq(user)
  end
end
