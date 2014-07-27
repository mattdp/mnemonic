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

  def self.birthday_generator
    Person.find_each do |person|
      if person.birthday
        recent = person.farthest_from_big_bang_event("birthday")
        person.create_new_birthday_event unless (recent.present? && recent[0].start_date.year == person.next_birthday.year)
      end
    end
  end

  #function so easily switched for testing
  def self.current_date
    Date.today
  end

end
