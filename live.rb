require 'open-uri'
require 'nokogiri'

live_url = 'http://www.scorespro.com/rss2/live-soccer.xml'

rss = Nokogiri::XML(open(live_url))
feed = rss.xpath('//item').map do |i|
  {
    'title' => i.at_xpath('title').text, 
    'link' => i.at_xpath('link').text, 
    'guid' => i.at_xpath('guid').text + i.at_xpath('pubDate').text, 
    'description' => i.at_xpath('description').text,
    'thumbnail' => '',
    'date' => i.at_xpath('pubDate').text
  }
end
feed.each do |item|
  puts item['title']
  puts item['description']
  puts item['date']
  puts Time.parse(item['date']).to_i
end
