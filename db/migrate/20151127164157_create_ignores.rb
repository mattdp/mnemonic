class CreateIgnores < ActiveRecord::Migration
  def change
    create_table :ignores do |t|
      t.string :filter
      t.string :info

      t.timestamps
    end
  end
end
