#from https://robots.thoughtbot.com/griddler-is-better-than-ever

Griddler.configure do |config|
  config.processor_class = EmailProcessor
  config.processor_method = :process 
  config.email_service = :mailgun
end