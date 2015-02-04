class RemoveBookIdAndUserIdFromReviews < ActiveRecord::Migration
  def up
    remove_column :reviews, :book_id
    remove_column :reviews, :user_id
  end

  def down
    add_column :reviews, :book_id, :integer
    add_column :reviews, :user_id, :integer

    Review.transaction do
      Review.all.each do |review|
        # reviewに対応するcollectionはnilになることはない
        collection = Collection.find(review.collection_id)

        review.update!(book_id: collection.book_id, user_id: collection.user_id)
      end
    end
  end
end
