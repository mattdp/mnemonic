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

end
