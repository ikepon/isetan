# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    name "MyString"
    email "MyString"
    user_name "MyString"
    category "MyString"
    content "MyText"
    deal false
  end
end
