class AddParentIdToTweet < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :parent_id, :integer
  end
end
