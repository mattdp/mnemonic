# == Schema Information
#
# Table name: tags
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  name_for_link :string(255)
#  notes         :text
#  created_at    :datetime
#  updated_at    :datetime
#

class Tag < ActiveRecord::Base

  has_many :taggings

  def self.proper_name_for_link(words)
    return words.downcase.gsub(/\W+/, "")
  end

end
