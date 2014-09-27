# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  person_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  verb_id    :integer
#

class Tagging < ActiveRecord::Base

  belongs_to :tag
  belongs_to :person
  belongs_to :verb

  def self.create_without_duplicates(person_id,verb_id,tag_id)
    tagging = Tagging.where("person_id = ? and verb_id = ? and tag_id = ?", person_id, verb_id, tag_id)
    if tagging == []
      return Tagging.create({person_id: person_id, verb_id: verb_id, tag_id: tag_id})
    else
      return nil
    end
  end

end
