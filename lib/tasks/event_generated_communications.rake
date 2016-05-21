desc 'one off - switch all event_generated communications to correct medium'
task :event_generated_communications => :environment do
  communications = Communication.where("event_id > 0")
  communications.each do |c|
    c.medium = "live"
    c.save
  end
end
