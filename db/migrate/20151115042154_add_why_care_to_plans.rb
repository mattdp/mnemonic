class AddWhyCareToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :why_care, :text
  end
end
