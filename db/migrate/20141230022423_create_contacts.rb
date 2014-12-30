class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :user_name
      t.string :category
      t.text :content
      t.boolean :deal

      t.timestamps
    end
  end
end
