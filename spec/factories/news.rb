FactoryGirl.define do
  factory :news do
    sequence(:title) {|n| "Title#{n}"}
    sequence(:content) {|n| "Content#{n}content#{n}content#{n}content#{n}content#{n}content#{n}content#{n}content#{n}content#{n}content#{n}content#{n}content#{n}content#{n}"}
  end
end
