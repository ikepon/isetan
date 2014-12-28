class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.integer :wanted, default: 0, null: false
      t.integer :read,   default: 0, null: false
      t.integer :rental, default: 0, null: false

      t.timestamps
    end
    add_index :books, :title
    add_index :books, :isbn, unique: true
  end
end
