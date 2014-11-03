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

  def most_common_verb_id
    connection = ActiveRecord::Base.connection
    sql = "SELECT COUNT(*) AS count, t1.verb_id FROM taggings t1 WHERE t1.tag_id='#{self.id}' GROUP BY t1.verb_id ORDER BY count DESC"
    rows = connection.select_all(sql).rows
    if rows.present?
      return rows.first[1]
    else
      return Verb.find_by_name("UNKNOWN").id
    end
  end

  def self.proper_name_for_link(words)
    return words.downcase.gsub(/\W+/, "")
  end

  def tagged_people
    self.taggings.map{|tagging| tagging.person}.sort_by{|person| person.last_name}
  end

  def self.all_sorted
    Tag.all.sort_by{|tag| tag.name}
  end

end
