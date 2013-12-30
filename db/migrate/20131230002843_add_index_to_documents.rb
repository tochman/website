class AddIndexToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :project_id, :integer
  end
  def up
    add_index "projects", ["project_id"], name: "index_documents_on_project_id", using: :btree
  end
end
