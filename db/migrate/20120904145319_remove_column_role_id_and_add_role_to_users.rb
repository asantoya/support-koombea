class RemoveColumnRoleIdAndAddRoleToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :role_id
    add_column :users, :role, :string
  end
  def down
    add_column :users, :role_id, :integer
    add_index :users, :role_id
    remove_column :users, :role
  end
end
