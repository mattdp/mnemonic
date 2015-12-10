#  email                    :string(255)
#  url_linkedin             :string(255)
#  url_facebook             :string(255)
#  phone                    :string(255)

desc 'create contact methods for all people, before deleting those Person fields'
task :cm_creator => :environment do
  #dropping url for filter names
  mapping = {email: "email", phone: "phone", 
    url_linkedin: "linkedin", url_facebook: "facebook"}
  Person.find_each do |person|
    mapping.keys.each do |key|
      value = person.send(key)
      if value.present?
        ContactMethod.create(filter: mapping[key],
          info: value,
          person_id: person.id)
      end
    end
  end
end