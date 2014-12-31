# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  start_date     :date
#  fade_date      :date
#  fade_action    :string(255)
#  dismissed      :boolean          default(FALSE)
#  content        :string(255)
#  notes          :text
#  event_type     :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  person_id      :integer
#  year           :integer
#  happening_date :date
#

class Event < ActiveRecord::Base
  belongs_to :person

  def self.birthday_generator(verbose=false)
    Person.find_each do |person|
      if person.birthday && !person.estranged?
        recent = person.farthest_from_big_bang_event("birthday")
        if (recent.present? && recent[0].year == person.next_birthday.year)
          puts "Skipping #{person.name}, next birthday already in place"
        else    
          person.create_new_birthday_event
        end
      end
    end
  end

  #function so easily switched for testing
  def self.current_date
    Date.today
  end

  def dismiss
    self.dismissed = true
    self.save
  end

  def self.get(event_type,undismissed=true)
    if undismissed
      Event.where("event_type = ? and dismissed = false",event_type)
    else
      Event.where("event_type = ?",event_type)
    end
  end

  def self.get_displayable(event_type)
    events = Event.get(event_type,true).select{|e| e.start_date && e.start_date <= Event.current_date}
    return events.select{|e| e.fade_date.nil? || Event.current_date < e.fade_date}
  end

  def self.get_current_happening
    events = Event.where("happening_date IS NOT NULL and dismissed = false").select{|e| e.start_date && e.start_date <= Event.current_date}
    return events.select{|e| e.fade_date.nil? || Event.current_date < e.fade_date}
  end

end
