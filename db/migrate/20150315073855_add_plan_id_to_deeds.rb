class AddPlanIdToDeeds < ActiveRecord::Migration
  def change
    add_column :deeds, :plan_id, :integer
  end
end
