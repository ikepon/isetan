FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "user_name#{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
    password_digest "user_password"
    profile "my profile"
  end
end
