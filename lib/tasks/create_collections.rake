namespace :db do
  namespace :seed do
    task 'create_collections' => :environment do
      book_stat = [1, 1, 2, 3]

      40.times do |i|
        rented_at = DateTime.new(2014, 10, 1) + i
        returned_at = rented_at + 7

        FactoryGirl.create(
          :collection,
          status: book_stat[i % 4],
          rented_at: rented_at,
          returned_at: returned_at,
          user_id: 1,
          book_id: (i % 20) + 1
        )
      end
    end
  end
end
