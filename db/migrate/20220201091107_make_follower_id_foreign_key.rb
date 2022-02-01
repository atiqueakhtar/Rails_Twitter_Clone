class MakeFollowerIdForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :followers, :users, column: :follower_id, primary_key: :id
  end
end
