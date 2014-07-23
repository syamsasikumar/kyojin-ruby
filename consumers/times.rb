require_relative 'consumer'

class Times < Consumer

  def get_data
    rss = get_rss 'http://www.thetimes.co.uk/tto/sport/football/rss'
    feeds = rss.xpath('//item').map do |i|
      {
        'title' => i.at_xpath('title').text, 
        'link' => i.at_xpath('link').text, 
        'description' => i.at_xpath('description').text,
        'thumbnail' => '',
        'date' => i.at_xpath('pubDate').text
      }
    end
    return feeds
  end
  
end