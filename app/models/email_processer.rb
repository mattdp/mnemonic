class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    puts "*\n*\n*\nEMAIL RECEIVED*\n*\n*\n"
    puts "To: #{@email.to[:email]}"
    puts "From: #{@email.from[:email]}"
    puts "Contents: #{@email.subject} ::: #{@email.body}"
  end

end