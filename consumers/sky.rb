require_relative 'consumer'

class Sky < Consumer

  def get_data
    rss = get_rss 'http://www.skysports.com/rss/0,20514,11095,00.xml'
    feeds = rss.xpath('//item').map do |i|
      thumb = i.at_xpath('enclosure').attr('url') if i.at_xpath('enclosure') && i.at_xpath('enclosure').attr('type') == 'image/jpg'
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
