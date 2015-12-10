class AddPersonIToContactMethods < ActiveRecord::Migration
  def change
    add_column :contact_methods, :person_id, :integer
  end
end
