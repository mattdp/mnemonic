class AddYearToEvents < ActiveRecord::Migration
  def change
    add_column :events, :year, :integer
  end
end
