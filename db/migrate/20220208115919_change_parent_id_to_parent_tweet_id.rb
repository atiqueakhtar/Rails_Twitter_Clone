class ChangeParentIdToParentTweetId < ActiveRecord::Migration[6.1]
  def change
    rename_column :tweets, :parent_tweet_id, :parent_tweet_id
  end
end
