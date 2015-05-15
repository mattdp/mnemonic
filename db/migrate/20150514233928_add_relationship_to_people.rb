class AddRelationshipToPeople < ActiveRecord::Migration
  def change
    add_column :people, :relationship_current, :integer
    add_column :people, :relationship_possible, :integer
  end
end
