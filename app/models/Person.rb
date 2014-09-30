# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  birthday     :date
#  first_name   :string(255)
#  last_name    :string(255)
#  email        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  notes        :text
#  how_met      :text
#  url_linkedin :string(255)
#  url_facebook :string(255)
#  name         :string(255)
#

require 'action_view'
include ActionView::Helpers::DateHelper

class Person < ActiveRecord::Base
  has_many :events
  has_many :taggings
  has_many :tags, :through => :taggings
  has_many :verbs, :through => :taggings

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      nil
    end
  end

  def add_tag(tag_id)
    tag = Tag.find_by_id(tag_id)
    return false if self.tags.include?(tag)
    self.tags << tag
    return true
  end

  def remove_tags(tag_id)
    self.tags.destroy(tag_id)
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

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

  #for showing up well on rails admin pages
  def generate_name
    self.name = self.full_name
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
    event.start_date = self.next_birthday - 7.days
    event.year = self.next_birthday.year
    event.event_type = "birthday"
    event.content = "#{self.first_name} #{self.last_name}: Turns #{self.age(self.next_birthday)} on #{self.next_birthday.to_s}"
    event.dismissed = false
    event.save
  end

  def self.facebook_mass_importer
    v2_fb_access_token = "CAACEdEose0cBAIrAZAzqxQS71hWQVhj95OVDrUhpPgUfkdLO6AWq4iAT2tgcj8jdL1ZC6U69ZBrvgZAvgS8F6SfnsiNN1w60Se8LxkfU0j5SoFXUwB7vEbIRtlNDCUOae9XsQPwcr7ZCOHSPhBXvAvF66tPb6nNAkusbCmGE5YWLi2PurjKZAZAzIAuZC1AO58HACUvcYbKoxoFQx5LTEnPg"
    v1_fb_access_token = "CAACEdEose0cBAEV4BGSMD4TBD5qCxZBX0QYsboqGThQqAplfk8BN4ZCDrfmhtpRiZBZCbaW2XY6LHPG7DaHiK1UDGFSyfxMkGZAKG5GN4WVgifV19khavZAe9DuuFSMH6gDuzR1fKXEFZAY7sWhZB2vgb12xyi7ihx1jcshnJkxG7gEazvuuN6HWRc7f7j5nZC6AJZC4SdqKA7PUqZBZBr4qgo1X"
  end

end
