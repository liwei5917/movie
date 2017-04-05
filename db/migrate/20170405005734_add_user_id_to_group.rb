class AddUserIdToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :films, :user_id, :integer
  end
end
