class AddTweetTypeToNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :tweet_type, :string
    change_column :notifications, :flag, :string, default: "unread"
  end
end
