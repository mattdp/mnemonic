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

    puts "*\n*\n*\nEMAIL RECEIVED*\n*\n*\n"
    puts parsed 
  end

end