# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  ask         :string(255)
#  answer_type :string(255)
#  ordering    :integer          default(0)
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#

class Question < ActiveRecord::Base
  has_many :surveys, through: :answers
  has_one :answer

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
