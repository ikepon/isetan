FactoryGirl.define do
  factory :book do
    sequence(:title) {|n| "BookTitle#{n}"}
    sequence(:isbn) {|n| "123456789#{n}"}
    sequence(:wanted) {|n| "1#{n}"}
    sequence(:read) {|n| "3#{n}"}
    sequence(:rental) {|n| "5#{n}"}
  end
end
