class RemoveNameAndPathOfDocuments < ActiveRecord::Migration
  def up
    remove_column :documents, :name
    remove_column :documents, :path
  end

  def down
    add_column :documents, :name, :string
    add_column :documents, :path, :string
  end
end