class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      # reference to user table
      t.references :user, null: false, foreign_key: true
      # reference to friend table
      t.references :friend, references: :users, foreign_key: { to_table: :users}
      t.timestamps
    end
  end
end
