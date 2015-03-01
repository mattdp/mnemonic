# == Schema Information
#
# Table name: answers
#
#  id              :integer          not null, primary key
#  survey_id       :integer
#  question_id     :integer
#  content_text    :text
#  content_integer :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Answer < ActiveRecord::Base

  belongs_to :question
  belongs_to :survey

  def get_answer
    answer_type = self.question.answer_type
    case answer_type
    when "integer"
      content_integer
    when "text"
      content_text
    else 
      "Type unspecified. Fix the code!"
    end
  end

end
