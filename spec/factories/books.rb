FactoryGirl.define do
  factory :book do
    title 'ステキな本'
    asin '123-1234567890'
    wanted 1
    read 3
    rental 5
  end
end
