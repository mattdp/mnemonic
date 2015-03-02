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
  has_many :answers

  validates :name, presence: true, uniqueness: {case_sensitive: false}, allow_nil: true

  #set should be changed in the future
  #requires that the questions already exist
  def equip_with_questions(set=nil)
    set = ["now_how_happy","now_how_alert","now_how_purposeful","self_reflection"]
    set.each do |name|
      q = Question.find_by_name(name)
      a = Answer.create({survey_id: self.id, question_id: q.id})
    end
  end

end
