require 'nokogiri'
require 'open-uri'
require_relative '../app/models/table.rb'

class Scraper

  def initialize
    @table = Table.new
    @tables_new = []
    @scraper = Scraper.new
  end

  def fetch_pingpong_tables

    num_pages_to_scrape = 1
    # num_pages_to_scrape = 290 // all pages to scrap from
    count = 0
    webcount = 0

    # mech_page = @agent.get("https://pingpongmap.net/index.php?typ=list&zeig=#{webcount}")

    while(num_pages_to_scrape > count)
      url = "https://pingpongmap.net/index.php?typ=list&zeig=#{webcount}"
      html_file = open(url).read
      html_doc = Nokogiri::HTML(html_file)


      html_doc.search('.list_item .inner').each do |link|

      @tables_new << {location: link.content.strip.split("\n")[2].strip, description: link.content.strip.split("\n")[1].strip}
      end

      webcount += 30
      count += 1
    end

    @tables_new.each do |table|
    p Table.create!(table)
    end
  end
  fetch_pingpong_tables
end


# r = PingPongScraper.new
# r.fetch_pingpong_tables

# puts r.instance_variable_get(:@tables)
# puts r.instance_variable_get(:@tables).count
