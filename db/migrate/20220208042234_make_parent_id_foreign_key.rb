class MakeParentIdForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :tweets, :tweets, column: :parent_tweet_id, primary_key: :id
  end
end
