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

      end
    end
  end

  def self.most_recent_event(person,type)
    Event.where("person_id = ? and type = ?",person.id,type).order("created_at").take(1)
  end

end
