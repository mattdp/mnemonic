source 'https://rubygems.org'
ruby "2.1.6"

gem 'rails', '~>4.1.0'
gem 'bcrypt-ruby'
gem 'jquery-rails'
#https://jamandbees.net/2014/05/24/postgres-homebrew-and-rails-on-mac-os-x-mavericks/
#http://stackoverflow.com/questions/17633422/psql-fatal-database-user-does-not-exist#17936043
#http://blog.willj.net/2011/05/31/setting-up-postgresql-for-ruby-on-rails-development-on-os-x/
gem 'pg', '0.17.1' 
gem 'rails_admin'
gem 'koala', '~> 1.10.0rc'
gem 'nokogiri', '1.6.0' #version bumping this causes an error, dunno why
gem 'activerecord-session_store'
gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'devise'
gem "compass-rails", github: "Compass/compass-rails", branch: "master"
gem 'chosen-rails'
gem 'griddler-mailgun'
gem 'd3-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-nav'
end

group :production do
  gem 'uglifier'
  gem 'rails_12factor'
end

group :development do
  gem 'annotate'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :assets do 
  gem 'twitter-bootstrap-rails'
  gem "therubyracer"
end