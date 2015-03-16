# == Schema Information
#
# Table name: deeds
#
#  id               :integer          not null, primary key
#  accomplished     :boolean
#  minutes          :integer
#  before_survey_id :integer
#  after_survey_id  :integer
#  created_at       :datetime
#  updated_at       :datetime
#  plan_id          :integer
#

class Deed < ActiveRecord::Base

  belongs_to :plan
  belongs_to :before_survey, class_name: "Survey"
  belongs_to :after_survey, class_name: "Survey"

#      t.boolean :accomplished #if so, and not repeater, set dismissed true
#      t.integer :minutes #how long did you do this

end
