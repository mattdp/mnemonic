# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  start_date  :date
#  fade_date   :date
#  fade_action :string(255)
#  dismissed   :boolean
#  content     :string(255)
#  notes       :string(255)
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  person_id   :integer
#

class Event < ActiveRecord::Base
  belongs_to :person
end
