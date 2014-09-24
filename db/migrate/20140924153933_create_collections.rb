class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :status
      t.date :rented_at
      t.date :returned_at
      t.references :user
      t.references :book

      t.timestamps
    end
    add_index :collections, :user_id
    add_index :collections, :book_id
  end
end
