# == Schema Information
#
# Table name: verbs
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Verb < ActiveRecord::Base
  has_many :taggings
  has_many :people, :through => :taggings
end
