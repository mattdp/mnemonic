class Misc < ActiveRecord::Migration
  def change
    change_column :events, :dismissed, :boolean, :default => false
    change_column :events, :notes, :text
    add_column :people, :notes, :text
  end
end
