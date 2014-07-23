require 'nokogiri'
require 'open-uri'

class Consumer
  def get_rss url
    return Nokogiri::XML(open(url))
  end
end