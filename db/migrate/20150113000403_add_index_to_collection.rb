class AddIndexToCollection < ActiveRecord::Migration
  def change
    add_index :collections, [:user_id, :book_id], :unique => true
  end
end
