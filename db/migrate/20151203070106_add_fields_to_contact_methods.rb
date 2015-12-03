class AddFieldsToContactMethods < ActiveRecord::Migration
  def change
    add_column :contact_methods, :ignore, :boolean, default: false
    add_column :contact_methods, :preferred_within_filter, :boolean, default: false
  end
end
