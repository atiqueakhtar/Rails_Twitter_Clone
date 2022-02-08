class AddTypeToTweet < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :type, :string
  end
end
