require_relative 'consumer'

class Times < Consumer

  def get_data
    rss = get_rss 'http://www.thetimes.co.uk/tto/sport/football/rss'
    feeds = rss.xpath('//item').map do |i|
      {
        'title' => i.at_xpath('title').text, 
        'link' => i.at_xpath('link').text, 
        'guid' => i.at_xpath('guid').text,
        'description' => i.at_xpath('description').text,
        'thumbnail' => '',
        'date' => Time.parse(i.at_xpath('pubDate').text).to_i
      }
    end
    return feeds
  end
  
end