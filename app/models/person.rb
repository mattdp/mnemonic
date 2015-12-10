# == Schema Information
#
# Table name: people
#
#  id                       :integer          not null, primary key
#  birthday                 :date
#  first_name               :string(255)
#  last_name                :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  notes                    :text
#  name                     :string(255)
#  relationship_current     :integer
#  relationship_possible    :integer
#  reminder_days            :integer
#  reminder_manual_override :boolean          default(FALSE)
#  prospective              :boolean
#

require 'action_view'
include ActionView::Helpers::DateHelper

class Person < ActiveRecord::Base
  has_many :communications, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :taggings
  has_many :tags, :through => :taggings
  has_many :verbs, :through => :taggings
  has_many :contact_methods, :dependent => :destroy

  before_save {|person| person.name = person.display_name if (!person.name.present? or person.name == person.first_name)}

  #currently accepts "email", "linkedin", "facebook", "phone"
  #in order of priority, gives:
  # => the preferred contact info for this filter/person combo
  # => the alphabetically first contact info for this f/p
  # => nil
  def contact_info(filter)
    cm = self.contact(filter)
    cm.present? ? cm.info : nil
  end

  def contact(filter)
    cms = ContactMethod.where(filter: filter.to_s, person_id: self.id)
      .order(:info)
    return nil if cms.blank?
    preferred = cms.select{|cm| cm.preferred_within_filter}
    preferred.present? ? (return preferred[0]) : (return cms[0])
  end

  def controller_save(hash)
    if hash["communication_id"].present?
      communication = Communication.find(hash["communication_id"])
      communication.contents = hash["communication_contents"]
      communication.save
    end
    if hash["tags"].present?
      hash["tags"].each do |tag_id|
        person.add_tag(tag_id.to_i)
      end
    end
    self.prospective = false
    hash.except!("communication_id","communication_contents","tags","select_action")
    self.assign_attributes(hash)
    self.save
  end

  def self.overview_attributes
    [:first_name, :last_name, :email, :phone, :relationship_current, :relationship_possible] 
  end

  #gives back an ignore, a new person, or an existing person
  def self.react_to_email(email_of_interest)
    return false if email_of_interest.blank?
    cm = ContactMethod.find_by_info(email_of_interest)
    return cm if (cm.present? and cm.ignore)

    person = Person.find_by_email(email_of_interest)
    return person if person.present?
    return Person.create(email: email_of_interest, prospective: true)
  end

  def self.names_for_search
    Person.all.map{|p| "#{p.display_name} [#{p.id}]"}
  end

  def self.create_event_related_person!(hash,event,verb_id,tag_id)
    if (hash["first_name"].present? or hash["last_name"].present?)
      person = Person.create({first_name: hash["first_name"], last_name: hash["last_name"]})
      Tagging.create_without_duplicates(person.id,verb_id,tag_id)
      Communication.create_event_related_communication!(event,person.id,"Saw at event '#{event.content}'")
    end
  end

  #logic for which relationship_current and relationship_possible get reminders...
  #...is in both this method and set_reminder_days
  def self.generate_all_reminder_days!
    people = Person.where("(relationship_possible = 3 OR relationship_possible = 4) 
      AND reminder_manual_override = FALSE
      AND relationship_current IS NOT NULL"
      )
    people.each do |person|
      person.set_reminder_days!
    end      
  end

  def set_reminder_days!(ignore_override=false)

    if self.reminder_manual_override 
      return nil unless ignore_override
    end
    rd = nil

    if self.relationship_possible == 4
      rd = 90 #4,2 and 4,1
      rd = 30 if relationship_current == 4 #already at great state
      rd = 15 if relationship_current == 3 #actively developing
    elsif self.relationship_possible == 3
      rd = 90 if relationship_current == 3 # not pushing dev in this area now
    end

    self.reminder_days = rd
    return self.save
  end

  def self.generate_all_reminder_events!
    remind_x_days_before = 3
    event_type = "auto_generated_communication_reminder"

    people = Person.where("reminder_days IS NOT NULL")

    people.each do |person|
      happening_date = nil
      next if person.has_undismissed_event?(event_type)
      lcd = person.last_communication_date
      if lcd.nil?
        happening_date = Date.today
      elsif (lcd + person.reminder_days.days + remind_x_days_before.days <= Date.today)
        happening_date = Date.today + remind_x_days_before
      end
      
      if happening_date.present?
        Event.create(person_id: person.id, event_type: event_type, start_date: Date.today,
          happening_date: happening_date, content: "#{person.display_name}: >= #{person.reminder_days} days since you reached out!"
          )
      end 
    end

    return true
  end

  def has_undismissed_event?(event_type)
    events = Event.where("person_id = ? AND event_type = ? AND dismissed = FALSE", self.id, event_type)
    return events.present?
  end

  def last_communication_date
    comms = Communication.where("person_id = ?", self.id)
    return nil unless comms.present?
    return comms.map{|c| c.canonical_date}.max
  end

  def feed
    combined = []
    combined = combined.concat(self.events) if self.events.present?
    combined = combined.concat(self.communications) if self.communications.present?
    combined = combined.sort_by{|c| c.created_at}.reverse if combined.present?
    return combined
  end

  def self.table_order
    Person.where("relationship_current IS NOT NULL AND relationship_possible IS NOT NULL") \
      .order(:relationship_possible, :relationship_current)
  end

  def self.select_group(symbol)
    estranged_tag = Tag.find_by_name("estranged")
    estranged_people = Tagging.where("tag_id = ?",estranged_tag.id).map{|tagging| tagging.person}.uniq
    if symbol == :estranged
      estranged_people
    elsif symbol == :not_estranged
      Person.all.reject{|person| estranged_people.include?(person)}
    else
      return "This should not happen. select_group error."
    end
  end

  def self.simple_name_splitter
    people = Person.where('first_name IS NULL and last_name IS NULL')
    people.each do |person|
      person.simple_name_splitter_helper
    end
  end

  def simple_name_splitter_helper
    split = self.name.split(" ")
    if split && split.count == 2
      self.first_name = split[0]
      self.last_name = split[1]
      self.save
      return "#{self.name} split!"
    end
    return "#{self.name} not split."
  end

  def self.email_list(people)
    emails = people.map{|person| person.contact_info(:email)}.reject{|x| x.nil?}
    emails.join ", "
  end

  def link_string
    "/admin/person/#{self.id}/edit"
  end

  def estranged?
    estranged_id = Tag.find_by_name("estranged").id
    return self.has_tag?(estranged_id)
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      nil
    end
  end

  def estrange
    tag = Tag.find_by_name("estranged")
    verb = Verb.find_by_name("is")
    Tagging.create_without_duplicates(self.id,verb.id,tag.id)
  end

  def add_tag(tag_id, verb_id = nil)
    tag = Tag.find_by_id(tag_id)
    return false if self.tags.include?(tag)
    verb_id = tag.most_common_verb_id if verb_id.nil?
    Tagging.create_without_duplicates(self.id,verb_id,tag.id)
  end

  def has_tag?(tag_id)
    t = Tag.find_by_id(tag_id)
    return false if t.nil?    
    if self.tags.include?(t)
      return true
    else
      return false
    end
  end

  def display_name
    if (self.first_name.present? && self.last_name.present?)
      return "#{self.first_name} #{self.last_name}"
    elsif self.name.present?
      return self.name
    elsif self.first_name.present?
      return self.first_name
    else
      return nil
    end
  end

  def display_birthday
    b = self.birthday
    if b.present?
      if b.year == 1900
        return b.strftime("%B %d")
      else
        return b.strftime("%B %d, %Y")
      end
    else
      return nil
    end
  end

  def display_age
    return "#{self.age} years old" if (age.present? && self.birthday.year != 1900) #it's ok that some people are 1.
    return nil
  end

  #for showing up well on rails admin pages
  def generate_name
    self.name = self.display_name
    self.save
  end

  def self.generate_all_blank_names
    Person.all.select{|p| p.name.nil? or p.name.empty?}.map{|p| p.generate_name}
  end

  def name_split_guesser
    self.first_name = /\A([\S]*)/.match(self.name)[1]
    self.last_name = /\A[\S]*\S([^\S].*)/.match(self.name)[1].strip
    self.save
  end

  def self.all_name_split_guesser
    eligibles = Person.all.select{|p| (p.first_name.nil? or p.first_name.empty?) and (p.last_name.nil? or p.last_name.empty?) }
    eligibles.map{|p| p.name_split_guesser}
  end

  # modified http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
  def age(on_date = Event.current_date)
    dob = self.birthday
    return nil if dob.nil?
    on_date.year - dob.year - ((on_date.month > dob.month || (on_date.month == dob.month && on_date.day >= dob.day)) ? 0 : 1)
  end

  # imagine this could be buggy around the new year
  def next_birthday
    this_year = Date.new(Event.current_date.year,self.birthday.month,self.birthday.day)
    next_year = Date.new(Event.current_date.year+1,self.birthday.month,self.birthday.day)
    if Event.current_date < this_year
      return this_year
    else
      return next_year
    end
  end

  #naming something that is either most recent or farthest in the future is hard
  def farthest_from_big_bang_event(type)
    Event.where("person_id = ? AND event_type = ? AND start_date IS NOT NULL",self.id,type) \
    .order("start_date desc").take(1)
  end

  def create_new_birthday_event
    event = Event.new
    event.person = self
    next_birthday = self.next_birthday
    event.start_date = next_birthday - 7.days
    event.happening_date = next_birthday
    event.year = next_birthday.year
    event.event_type = "birthday"
    event.content = "#{self.first_name} #{self.last_name}: Turns #{self.age(self.next_birthday)} on #{self.next_birthday.to_s}"
    event.dismissed = false
    event.save
  end

  def linkedin_updater(info)
    # take in hash "info", on per-person basis, like info[:first_name] = "Bob"
    # for each thing in there for a person test:
    # if it's in info, and not in current data (blank or "" or nil), add that
    change_flag = false
    info.keys.each do |key|
      if self[key].blank?
        change_flag = true
        self[key] = info[key]
      end
    end
    self.save if change_flag
  end

end
