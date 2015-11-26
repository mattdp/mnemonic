class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    puts "*\n*\n*\nEMAIL RECEIVED*\n*\n*\n"
    puts "@email class: #{@email.class}"
    puts "@email to class: #{@email.to.class}"
    puts "Contents: #{@email.subject} ::: #{@email.body}"
    puts "From: #{@email.from[:email]}"
    #https://github.com/thoughtbot/griddler
    #is an array of hashes, since possible multiple to's
    puts "To: #{@email.to[0][:email]}" 
  end

end