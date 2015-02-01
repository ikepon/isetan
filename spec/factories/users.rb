FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "user name#{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
    password 'password'
    password_confirmation 'password'
    profile 'たくさん本を読んで、いろんなことを知りたい、元気いっぱいの30代！'
    sign_in_count 0
  end
end
