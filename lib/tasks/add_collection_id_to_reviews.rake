namespace :add_data do
  task 'review_id_to_collections' => :environment do
    Rails.logger = Logger.new(Rails.root.join('log/review_id_to_collections.log'))
    Rails.logger.info "Remove review data to Collection start: #{Time.zone.now}"

    Review.transaction do
      Review.all.each do |review|
        collection = Collection.find_by(user_id: review.user_id, book_id: review.book_id)

        if collection.nil?
          collection = Collection.create!(user_id: review.user_id, book_id: review.book_id)
        end

        review.update!(collection_id: collection.id)
      end
    end

    Rails.logger.info "Remove review data to Collection finished: #{Time.zone.now}"
  end
end
