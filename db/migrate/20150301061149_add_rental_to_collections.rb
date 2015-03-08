class AddRentalToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :rental, :integer, default: 0
  end
end
