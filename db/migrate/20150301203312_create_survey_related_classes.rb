class CreateSurveyRelatedClasses < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.text :self_assessment

      t.timestamps
    end

    create_table :questions do |t|
      t.string :ask
      t.string :answer_type
      t.integer :ordering, default: 0

      t.timestamps
    end

    create_table :answers do |t|
      t.integer :survey_id
      t.integer :question_id

      t.text :content_text
      t.integer :content_integer

      t.timestamps
    end
  end
end
