class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :body
      t.belongs_to :project
      t.timestamps
    end
  end
end
