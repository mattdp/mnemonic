class TagsAndTaggings < ActiveRecord::Migration
  def change
    
    create_table :tags do |t|
      t.string :name
      t.string :name_for_link
      t.text :notes

      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :person_id

      t.timestamps
    end

  end
end