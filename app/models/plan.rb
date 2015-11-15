# == Schema Information
#
# Table name: plans
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  notes              :text
#  minimum_minutes    :integer
#  seems_purposeful   :boolean
#  requires_alertness :boolean
#  seems_fun          :boolean
#  repeater           :boolean
#  dismissed          :boolean
#  created_at         :datetime
#  updated_at         :datetime
#

class Plan < ActiveRecord::Base

  has_many :deeds
  
  # t.boolean :repeater #if accomplished, dismiss

  def self.undismissed
    Plan.all.select{|p| !p.dismissed}
  end

  def self.display_flags
    [:seems_purposeful, :requires_alertness, :seems_fun, :repeater]
  end
  
end
