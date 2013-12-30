class AddIndexToDocuments < ActiveRecord::Migration

  def up
    add_index :documents, ["project_id"], name: "index_documents_on_project_id", using: :btree
  end
end
