require_relative 'consumer'

class Guardian < Consumer

  def get_data
    rss = get_rss 'http://feeds.theguardian.com/theguardian/football/rss'
    feeds = rss.xpath('//item').map do |i|
      thumb = i.at_xpath('media:content').attr('url') if i.at_xpath('media:content')
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