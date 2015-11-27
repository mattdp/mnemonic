class AddProspectiveToPeople < ActiveRecord::Migration
  def change
    add_column :people, :prospective, :boolean
  end
end
