class AddUserIdToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :to_dos, :user_id, :int
  end
end
