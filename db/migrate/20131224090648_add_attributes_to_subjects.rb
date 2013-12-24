class AddAttributesToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :description, :text
    add_column :subjects, :group_url, :string
  end
end
