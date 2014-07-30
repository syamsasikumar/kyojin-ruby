#fetches live score updates and sends to mongolab
require 'open-uri'
require 'nokogiri'
require 'digest'
Dir['./db/*.rb'].each{ |f| require f }

live_url = 'http://www.scorespro.com/rss2/live-soccer.xml'
type = 'live'
source = 'live-soccer'
db = Db.new

rss = Nokogiri::XML(open(live_url))
feed = rss.xpath('//item').map do |i|
  {
    'title' => i.at_xpath('title').text, 
    'link' => i.at_xpath('link').text, 
    'guid' => Digest::MD5.hexdigest(i.at_xpath('guid').text + i.at_xpath('pubDate').text), 
    'description' => i.at_xpath('description').text,
    'thumbnail' => '',
    'date' => Time.parse(i.at_xpath('pubDate').text).to_i,
    'type' => type,
    'source' => source
  }
end

last_rec = db.get_latest_ts ({'type' => type, 'source' => source})

feed.each do |item|
  title_arr = item['title'].split(':')
  if title_arr.length > 1
    item['title'] = title_arr[1] + ' : ' + title_arr[2]
  end
  if last_rec.to_a.size == 0 || item['date'].to_i > last_rec['date']
    db.update_rec item
  end
end
