class DropRetweet < ActiveRecord::Migration[6.1]
  def change
    drop_table :retweets
  end
end
