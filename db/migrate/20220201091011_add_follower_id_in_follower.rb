class AddFollowerIdInFollower < ActiveRecord::Migration[6.1]
  def change
    add_column :followers, :follower_id, :integer
  end
end
