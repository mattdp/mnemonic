class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.integer :person_id
      t.string :medium
      t.date :when
      t.text :contents

      t.timestamps
    end
  end
end
