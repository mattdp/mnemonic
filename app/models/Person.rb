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
#  notes      :text
#

require 'action_view'
include ActionView::Helpers::DateHelper

class Person < ActiveRecord::Base
  has_many :events

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
    event.event_type = "birthday"
    event.content = "#{self.first_name} #{self.last_name}: Turns #{self.age(self.next_birthday)} on #{self.next_birthday.to_s}"
    event.dismissed = false
    event.save
  end

end
