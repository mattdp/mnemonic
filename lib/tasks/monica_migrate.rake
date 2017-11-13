desc 'move people over to Monica CRM'
task :monica_migrate => :environment do
  person = Person.find(1729)
end