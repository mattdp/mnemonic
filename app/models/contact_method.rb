# == Schema Information
#
# Table name: contact_methods
#
#  id                      :integer          not null, primary key
#  filter                  :string(255)
#  info                    :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  ignore                  :boolean          default(FALSE)
#  preferred_within_filter :boolean          default(FALSE)
#  person_id               :integer
#

class ContactMethod < ActiveRecord::Base
  #filter: what is the type of data in info. email? email_regex? phone?
  belongs_to :person
end
