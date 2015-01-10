namespace :db do
  namespace :seed do
    task 'create_reviews' => :environment do
      20.times do |i|
        FactoryGirl.create(
          :review,
          user_id: "#{i%3 + 1}",
          book_id: "#{i%15 + 1}",
          title: "#{i + 1} この本は名著ですね！",
          content: "#{i +1}いや〜、すばらしい！すばらしすぎて言葉がでない。",
          evaluation: "#{i%5 + 1}"
        )
      end
    end
  end
end
