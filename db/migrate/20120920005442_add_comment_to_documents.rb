class AddCommentToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :comment_id, :integer
    add_index :documents, :comment_id
  end
end
