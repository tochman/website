class AddStatusToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :public, :boolean
  end
end
