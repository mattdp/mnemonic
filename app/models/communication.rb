# == Schema Information
#
# Table name: communications
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  medium     :string(255)
#  when       :date
#  contents   :text
#  created_at :datetime
#  updated_at :datetime
#

class Communication < ActiveRecord::Base

  belongs_to :person

end
