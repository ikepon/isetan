class AddSignInCountAndCurrentSignInAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
  end
end
