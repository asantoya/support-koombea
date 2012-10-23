class AddDefaultAssignedToTickets < ActiveRecord::Migration
  def self.up
  	change_column :tickets, :assigned_to_id, :integer, :default => 0
  end

  def self.down
  	change_column :tickets, :assigned_to_id, :integer, :default => nil
  end
end
