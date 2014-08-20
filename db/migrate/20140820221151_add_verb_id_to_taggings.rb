class AddVerbIdToTaggings < ActiveRecord::Migration
  def change
    add_column :taggings, :verb_id, :integer
  end
end
