class AddDismissedReasonToEvents < ActiveRecord::Migration
  def change
    add_column :events, :dismissed_reason, :string
  end
end
