# == Schema Information
#
# Table name: ignores
#
#  id         :integer          not null, primary key
#  filter     :string(255)
#  info       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Ignore < ActiveRecord::Base
  #filter: what is the type of data in info. email? email_regex? phone?
end
