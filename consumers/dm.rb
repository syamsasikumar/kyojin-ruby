require_relative 'consumer'

class DM < Consumer

  def get_data
    rss = get_rss 'http://www.dailymail.co.uk/sport/football/articles.rss'
    feeds = rss.xpath('//item').map do |i|
      thumb = i.at_xpath('enclosure').attr('url') if i.at_xpath('enclosure') && i.at_xpath('enclosure').attr('type') == 'image/jpeg'
      {
        'title' => i.at_xpath('title').text, 
        'link' => i.at_xpath('link').text, 
        'guid' => i.at_xpath('guid').text,
        'description' => i.at_xpath('description').text,
        'thumbnail' => thumb,
        'date' => Time.parse(i.at_xpath('pubDate').text).to_i
      }
    end
    return feeds
  end

end