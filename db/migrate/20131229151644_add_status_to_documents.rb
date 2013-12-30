class AddStatusToDocuments < ActiveRecord::Migration
  def up
    add_column :documents, :project_id, :integer
  end
end
