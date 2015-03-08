class AddCollectionIdToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :collection_id, :integer
  end
end
