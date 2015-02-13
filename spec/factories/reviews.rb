FactoryGirl.define do
  factory :review do
    sequence(:title) { |n| "この本は名著です#{n}" }
    content "いや〜、すばらしい！すばらしすぎて言葉がでない。"
    evaluation 5

    trait :review_whatever do
      collection { create(:collection, :collection_whatever) }
    end
  end
end
