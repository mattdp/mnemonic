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
#

class Question < ActiveRecord::Base

end
