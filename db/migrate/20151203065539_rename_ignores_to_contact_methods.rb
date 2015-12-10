class RenameIgnoresToContactMethods < ActiveRecord::Migration
  def change
    rename_table :ignores, :contact_methods
  end
end
