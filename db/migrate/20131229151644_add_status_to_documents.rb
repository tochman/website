class AddStatusToDocuments < ActiveRecord::Migration
  def change_table
    add_column :documents, :project_id, :integer
  end
end
