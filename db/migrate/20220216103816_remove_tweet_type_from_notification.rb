class RemoveTweetTypeFromNotification < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :tweet_type, :string
  end
end
