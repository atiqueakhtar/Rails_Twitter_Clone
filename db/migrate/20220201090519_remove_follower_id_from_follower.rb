class RemoveFollowerIdFromFollower < ActiveRecord::Migration[6.1]
  def change
    remove_column :followers, :follower_id, :string
  end
end
