class EmailProcessor
  def initialize(email)
    @email = email
  end

  # Working as expected. Doesn't currently capture multiple to's
  def process
    parsed = {}
    parsed[:contents] = "#{@email.subject} ::: #{@email.body}"
    parsed[:from] = "#{@email.from[:email]}"
    #[:to] is an array of hashes, since possible multiple to's
    parsed[:to] = "#{@email.to[0][:email]}"

    person = Person.find_by_email(parsed[:to])
    if person.present?
      Communication.create(person_id: person.id,
        contents: parsed[:contents],
        medium: "email",
        when: Date.today)
    end
  end

end