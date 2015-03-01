# == Schema Information
#
# Table name: surveys
#
#  id              :integer          not null, primary key
#  self_assessment :text
#  created_at      :datetime
#  updated_at      :datetime
#  name            :string(255)
#

class Survey < ActiveRecord::Base
  has_many :questions, through: :answers
  has_one :answer

  validates :name, presence: true, uniqueness: {case_sensitive: false}, allow_nil: true
end
