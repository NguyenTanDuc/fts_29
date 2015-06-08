FactoryGirl.define do
  factory :user do
    name "normal"
    email "normal@gmail.com"
    password "12345678"
    password_confirmation "12345678"
    confirmed_at Time.zone.now

    factory :admin_user, :parent => :user do
      level 1
    end
  end
end