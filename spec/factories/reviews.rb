# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    user_id 1
    book_id 1
    title "MyString"
    review "MyText"
    evaluation 1
  end
end
