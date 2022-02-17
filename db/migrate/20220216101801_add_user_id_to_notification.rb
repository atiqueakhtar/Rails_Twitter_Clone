class AddUserIdToNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :tweet_user_id, :integer
  end
end
