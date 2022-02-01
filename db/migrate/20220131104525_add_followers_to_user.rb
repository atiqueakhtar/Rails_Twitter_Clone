class AddFollowersToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :followers, :integer
  end
end
