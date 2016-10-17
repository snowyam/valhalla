class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.integer :friended_id
      t.integer :friender_id

      t.timestamps
    end
    add_index :friendships, :friended_id
    add_index :friendships, :friender_id
    add_index :friendships, [:friended_id, :friender_id], unique: true
  end
end
