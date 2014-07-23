require_relative 'consumer'

class BBC < Consumer

  def get_data
    rss = get_rss 'http://feeds.bbci.co.uk/sport/0/football/rss.xml'
    feeds = rss.xpath('//item').map do |i|
      thumb = i.at_xpath('media:thumbnail').attr('url') if i.at_xpath('media:thumbnail')
      {
        'title' => i.at_xpath('title').text, 
        'link' => i.at_xpath('link').text, 
        'description' => i.at_xpath('description').text,
        'thumbnail' => thumb,
        'date' => i.at_xpath('pubDate').text
      }
    end
    return feeds
  end

end