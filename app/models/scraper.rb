require 'nokogiri'
require 'open-uri'

class Scraper

  def scrape_pingpong_tables
  @tables_new = []

    num_pages_to_scrape = 290
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
  @tables_new
  end
end

# scrape = Scraper.new
# scrape.scrape_pingpong_tables
