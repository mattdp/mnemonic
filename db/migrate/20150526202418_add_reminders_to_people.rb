class AddRemindersToPeople < ActiveRecord::Migration
  def change
    add_column :people, :reminder_days, :integer
    add_column :people, :reminder_manual_override, :boolean
  end
end
