# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    sequence(:title) {|n| "BookTitle#{n}"}
    sequence(:isbn) {|n| "123456789{n}"}
    wanted 1
    read 1
    rental 1
  end
end
