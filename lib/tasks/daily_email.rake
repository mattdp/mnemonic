desc 'send an email with to-dos for the day'
task :daily_email => :environment do
  UserMailer.daily_email.deliver
end