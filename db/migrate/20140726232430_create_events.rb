class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :start_date
      t.date :fade_date
      t.string :fade_action
      t.boolean :dismissed

      t.string :content
      t.string :notes
      t.string :type #[birthday, want, have] to start

      t.timestamps
    end
  end
end
