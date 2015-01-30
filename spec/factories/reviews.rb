FactoryGirl.define do
  factory :review do
    user nil
    book nil
    title "この本は名著ですね！"
    content "いや〜、すばらしい！すばらしすぎて言葉がでない。"
    evaluation 5

    trait :review_whatever do
      user { create(:user) }
      book { create(:book) }
    end
  end
end
