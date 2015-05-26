class ChangeDefaultToReminderFlag < ActiveRecord::Migration
  def change
    change_column :people, :reminder_manual_override, :boolean, :default => false
  end
end
