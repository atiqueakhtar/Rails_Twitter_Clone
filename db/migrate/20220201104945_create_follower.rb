class CreateFollower < ActiveRecord::Migration[6.1]
  def change
    create_table :followers do |t|
      t.integer :followed_id
      t.integer :follower_id

      t.timestamps
    end
  end
end
