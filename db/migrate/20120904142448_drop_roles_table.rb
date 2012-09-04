class DropRolesTable < ActiveRecord::Migration
  def up
    drop_table :roles
  end

  def down
     create_table :roles do |t|
      t.string :role

      t.timestamps
    end
  end
end
