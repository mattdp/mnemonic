class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    puts "*\n*\n*\nEMAIL RECEIVED*\n*\n*\n"
    puts "@email class: #{@email.class}"
    puts "@email to class: #{@email.to.class}"
    puts "To: #{@email.to[:email]}"
    puts "From: #{@email.from[:email]}"
    puts "Contents: #{@email.subject} ::: #{@email.body}"
  end

end