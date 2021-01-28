task :notify_me => :environment do
  Vacuna.scrape
end
