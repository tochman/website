class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :body
      t.date :created
      t.boolean :public

      t.timestamps
    end
  end
end
