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
  has_many :communications, dependent: :destroy
  has_one :tag, dependent: :destroy

  # dismiss reasons -> :success, :tried_openly, :pass, :pass_and_estrange

  # all events that aren't dismissed
  #   event is in top list if has a happening date
  #   event is in bottom list if has a start date and no happening date

  def attendee_list
    people_ids = self.communications.map{|c| c.person_id}
    clean_people_ids = people_ids.reject{|id| id.nil?}
    return Person.find(clean_people_ids)
  end

  def manual_event_date
    return self.happening_date if self.happening_date.present?
    return self.created_at
  end

  def make_event_tag
    nfl = Tag.proper_name_for_link(self.content)

    tag = Tag.find_by_name(self.content)
    tag = Tag.find_by_name_for_link(nfl) if tag.nil?

    if tag.present?
      tag.event_id = self.id
      tag.save
    else
      tag = Tag.create({name: self.content, 
        name_for_link: nfl,
        event_id: self.id
        })
    end

    return tag
  end

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

  #serves 2 purposes. easier: take a #, delay the date displayed by that long
  #harder: go to happening_date - 1 of an event, for example a birthday
  def snooze(days)
    days = days.to_i if (days.class.name == "String" and days != "day-1")

    if days == "day-1" and self.happening_date.present?
      self.start_date = self.happening_date - 1
      self.fade_date = self.start_date + 30 if self.fade_date.present?
    else
      #move back start_date and fade_date; happening stays same
      days = 7 if days == "day-1"
      self.start_date = Date.today + days
      self.fade_date = self.fade_date + days if self.fade_date.present?
    end
    return self.save
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
    answer[:closest] = Event.joins(:person)
      .where("dismissed = FALSE and start_date <= ?",date)
      .select{|e| e.person.present? and
        (e.person.relationship_possible == 4 or 
          (e.person.relationship_possible == 3 and 
          e.person.relationship_current == 3)
        )
      }
    answer[:specific_dates] = Event.where("happening_date IS NOT NULL")
      .where("dismissed = FALSE")
      .where("start_date <= ?",date)
      .order(:happening_date)
    answer[:ranges] = Event.where("happening_date IS NULL")
      .where("dismissed = FALSE")
      .where("start_date <= ?",date)
      .order(:start_date)      
      .select{|e| !e.fade_date.present? or e.fade_date >= date}

    #don't want redundancy
    if answer[:closest].present?
      closest_ids = answer[:closest].map{|e| e.id}
      [:specific_dates,:ranges].each do |key|
        answer[key] = answer[key].reject{|e| closest_ids.include?(e.id)}
      end
    end

    return answer
  end

end
