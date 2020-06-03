  namespace :app do
    desc "Scrape tables"
    task :scrape_tables => :environment do
      Table.connection
      Table.fetch_pingpong_tables
    end
  end
