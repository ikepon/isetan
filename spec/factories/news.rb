FactoryGirl.define do
  factory :news do
    sequence(:title) { |n| "機能実装したったぜ！#{n}" }
    content '蔵書、読書に関するあんなことや、こんなことか、こんなに簡単にできちゃうなんて素晴らしい！'
  end
end
