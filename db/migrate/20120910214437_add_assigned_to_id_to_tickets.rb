class AddAssignedToIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :assigned_to_id, :integer
    add_index :tickets, :assigned_to_id
  end
end
