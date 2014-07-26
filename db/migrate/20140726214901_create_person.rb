class CreatePerson < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.date :birthday
      t.string :first_name
      t.string :last_name
      t.string :email
    end
  end
end
