#from https://robots.thoughtbot.com/griddler-is-better-than-ever
require 'email_processor'

Griddler.configure do |config|
  config.email_service = :mailgun
end