# == Schema Information
#
# Table name: verbs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Verb < ActiveRecord::Base
  has_many :taggings
  has_many :people, :through => :taggings

  def name #testing for admin console
    self.description
  end

end
