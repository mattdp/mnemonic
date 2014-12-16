class AddHappeningDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :happening_date, :date
  end
end