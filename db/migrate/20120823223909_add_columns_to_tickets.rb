class AddColumnsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :status, :string
    add_column :tickets, :ticket_type, :string
    add_column :tickets, :user_id, :integer
    add_index :tickets, :user_id
  end
end
