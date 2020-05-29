require 'httparty'
require 'nokogiri'
require 'byebug'


def scraper
  url = "https://www.pingpongmap.net/Berlin"

  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)

  parsed_page.search('.inner').each do |element|
    puts element.text.strip
    puts element.attribute('href').value
end
end

scraper
