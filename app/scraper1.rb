require 'nokogiri'
require 'open-uri'
require 'mechanize'


class PingPongScraper

  def initialize
    @table_info = []
    @agent = Mechanize.new
  end

  def fetch_pingpong_tables

    num_pages_to_scrape = 1
    # num_pages_to_scrape = 290 // all pages to scrap from
    count = 0
    webcount = 0

    # mech_page = @agent.get("https://pingpongmap.net/index.php?typ=list&zeig=#{webcount}")

    while(num_pages_to_scrape > count)
      page = @agent.get("https://pingpongmap.net/index.php?typ=list&zeig=#{webcount}").parser

      page.css('.inner').each do |link|
        @table_info << { location: link.content, description: link.content }
      end
      @table_info

      webcount += 30
      count += 1
    end

    @table_info.each do |table|
     p table[:location]
     p table[:description]
   end
  end
end


r = PingPongScraper.new
r.fetch_pingpong_tables

# puts r.instance_variable_get(:@tables)
# puts r.instance_variable_get(:@tables).count
