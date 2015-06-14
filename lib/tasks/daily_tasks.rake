desc 'send an email with to-dos for the day'
task :daily_email => :environment do
  UserMailer.daily_email.deliver
end

desc 'update the reminder days for all people with certain relationship_possible levels'
task :generate_all_reminder_days => :environment do 
  Person.generate_all_reminder_days!
  Event.birthday_generator
end

desc 'generate reminder events for all people with reminder_days'
task :generate_all_reminder_events => :environment do 
  Person.generate_all_reminder_events!
end