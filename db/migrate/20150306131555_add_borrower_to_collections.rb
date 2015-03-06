class AddBorrowerToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :borrower_id, :integer
    add_index :collections, :borrower_id
    add_index :collections, :status
  end
end
