class AddLiAndMetToPeople < ActiveRecord::Migration
  def change
    add_column :people, :how_met, :text
    add_column :people, :url_linkedin, :string
    add_column :people, :url_facebook, :string
  end
end
