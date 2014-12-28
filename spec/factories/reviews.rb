FactoryGirl.define do
  factory :review do
    user_id 1
    book_id 1
    title "この本は名著ですね！"
    review "いや〜、すばらしい！すばらしすぎて言葉がでない。"
    evaluation 5
  end
end
