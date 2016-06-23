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
  has_many :surveys, through: :answer
  has_many :answers

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  #return answer if there is one; earliest reply in day if multiple
  def answer_on_date(date,no_response=0)
    a = Answer.where(question_id: self.id, created_at: date.beginning_of_day..date.end_of_day)
    return no_response unless a.present?
    answer = a[0].get_answer
    return no_response unless answer.present?
    return answer
  end

end
