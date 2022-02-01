class ChangeDefaultInFollowers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :followers, from: :nil, to: 0
  end
end
