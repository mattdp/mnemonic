class AddStuffForEventTagging < ActiveRecord::Migration
  def change
    add_column :communications, :event_id, :integer
    add_column :tags, :event_id, :integer
  end
end
