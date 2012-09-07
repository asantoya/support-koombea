class AddReceivesNotificationsToUser < ActiveRecord::Migration
  def change
    add_column :users, :receives_notifications, :boolean, :default => false
  end
end
