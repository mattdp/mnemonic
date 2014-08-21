class ChangeDescriptionInVerbs < ActiveRecord::Migration
  def change
    rename_column :verbs, :description, :name
  end
end
