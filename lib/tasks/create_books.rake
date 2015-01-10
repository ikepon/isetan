namespace :db do
  namespace :seed do
    task 'create_books' => :environment do
      20.times do |i|
        FactoryGirl.create(
          :book,
          title: "ステキな本 #{i + 1}",
          asin: "12312345#{i%2}#{i%3}#{i%5}#{i%7}#{i%9}",
          wanted: "#{i + 1}",
          read: "#{30 - i}",
          rental: "#{i+ 1}",
          created_at: DateTime.new(2014, 10, 1) + i
        )
      end
    end
  end
end
