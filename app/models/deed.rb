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
#

class Deed < ActiveRecord::Base

#      t.boolean :accomplished #if so, and not repeater, set dismissed true
#      t.integer :minutes #how long did you do this

end
