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

    email_of_interest = parsed[:to]
    if !(/@/.match(parsed[:to]))
      logger.warn "Poorly formatted email! parsed: #{parsed}"
    end

    object = Person.react_to_email(email_of_interest)
    if object.class.to_s == "Person"
      Communication.create(person_id: object.id,
        contents: parsed[:contents],
        medium: "email",
        when: Date.today)
    end
  end

end