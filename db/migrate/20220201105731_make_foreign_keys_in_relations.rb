class MakeForeignKeysInRelations < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :relations, :users, column: :follower_id, primary_key: :id
    add_foreign_key :relations, :users, column: :followed_id, primary_key: :id
  end
end
