class CreatePlansAndDeeds < ActiveRecord::Migration
  def change
    create_table :plans do |t|

      t.string :name
      t.text :notes
      t.integer :minimum_minutes
      t.boolean :seems_purposeful
      t.boolean :requires_alertness
      t.boolean :seems_fun
      t.boolean :repeater #if accomplished, dismiss
      t.boolean :dismissed

      t.timestamps
    end

    create_table :deeds do |t|
      t.boolean :accomplished #if so, and not repeater, set dismissed true
      t.integer :minutes #how long did you do this
      t.integer :before_survey_id
      t.integer :after_survey_id

      t.timestamps
    end
  end
end
