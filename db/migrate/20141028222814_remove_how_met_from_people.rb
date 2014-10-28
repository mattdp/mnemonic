class RemoveHowMetFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :how_met
  end
end
