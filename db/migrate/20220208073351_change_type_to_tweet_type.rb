class ChangeTypeToTweetType < ActiveRecord::Migration[6.1]
  def change
    rename_column :tweets, :type, :tweet_type
  end
end
