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
#  event_id   :integer
#

class Communication < ActiveRecord::Base

  belongs_to :person
  belongs_to :event

  #stub so can use for event setting
  def canonical_date
    self.created_at
  end

end
