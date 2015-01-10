class RenameIsbnColumnToBooks < ActiveRecord::Migration
  def change
    rename_column :books, :isbn, :asin
  end
end
