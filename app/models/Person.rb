# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  birthday   :date
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Person < ActiveRecord::Base
  has_many :events

  def most_recent_event(type)
    Event.where("person_id = ? AND event_type = ? AND start_date IS NOT NULL",self.id,type) \
    .order("start_date desc").take(1)
  end

end
