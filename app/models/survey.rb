# == Schema Information
#
# Table name: surveys
#
#  id              :integer          not null, primary key
#  self_assessment :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Survey < ActiveRecord::Base

end
