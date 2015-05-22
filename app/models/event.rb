# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  start_date       :date
#  fade_date        :date
#  fade_action      :string(255)
#  dismissed        :boolean          default(FALSE)
#  content          :string(255)
#  notes            :text
#  event_type       :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  person_id        :integer
#  year             :integer
#  happening_date   :date
#  dismissed_reason :string(255)
#

class Event < ActiveRecord::Base
  belongs_to :person

  # dismiss reasons -> :success, :tried_openly, :pass, :pass_and_estrange

  # all events that aren't dismissed
  #   event is in top list if has a happening date
  #   event is in bottom list if has a start date and no happening date

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

  def dismiss(reason=nil)
    self.dismissed = true
    self.dismissed_reason = reason
    if reason == "pass_and_estrange"
      if person = self.person
        person.estrange
      end
    end
    self.save
  end

  def self.get(event_type,undismissed=true)
    if undismissed
      Event.where("event_type = ? and dismissed = false",event_type)
    else
      Event.where("event_type = ?",event_type)
    end
  end

  def self.events_by_display_category(date = Event.current_date)
    answer = {}
    answer[:specific_dates] = Event.where("happening_date IS NOT NULL and dismissed = FALSE and start_date <= ?",date).order(:happening_date)
    answer[:ranges] = Event.where("happening_date IS NULL and dismissed = FALSE and start_date <= ? and fade_date >= ?",date,date).order(:start_date)
    return answer
  end

end
