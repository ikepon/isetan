FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "user_name#{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
    password "user_password"
    password_confirmation "user_password"
    profile "my profile"
  end
end
