class AddIndexToDocuments < ActiveRecord::Migration
  # TODO: This is clearly a mistake?!?
  def up
    #add_index :documents, ["project_id"], name: "index_documents_on_project_id", using: :btree
  end
end
