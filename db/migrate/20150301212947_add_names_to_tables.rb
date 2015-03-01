class AddNamesToTables < ActiveRecord::Migration
  def change
    add_column :surveys, :name, :string
    add_column :questions, :name, :string
  end
end
