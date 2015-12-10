class RemoveContactFieldsFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :email
    remove_column :people, :phone
    remove_column :people, :url_linkedin
    remove_column :people, :url_facebook
  end
end
