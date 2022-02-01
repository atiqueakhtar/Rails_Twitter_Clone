class RemoveTitleStatusFromTweet < ActiveRecord::Migration[6.1]
  def change
    remove_column :tweets, :title, :string
    remove_column :tweets, :status, :string
  end
end
