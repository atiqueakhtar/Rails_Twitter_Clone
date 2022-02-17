class RenameUserTweetIdToNotifierId < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :tweet_user_id, :notifier_id
  end
end
