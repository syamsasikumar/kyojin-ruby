#source to fetch soccer news from UK News papers RSS feeds - sends to mongolab
require 'sanitize'
require 'htmlentities'
require 'digest'
Dir['./consumers/*.rb'].each{ |f| require f }
Dir['./db/*.rb'].each{ |f| require f }

def sanitize text
  return Sanitize.fragment(text).split.join(' ')
end

type = 'news'
#news_source = ['bbc', 'sky', 'dm', 'times', 'guardian'] DM seems to send too many
news_source = ['bbc', 'sky', 'times', 'guardian']
db = Db.new

consumer_factory = ConsumerFactory.new
news_source.each do |source|
  feed = consumer_factory.get_feed source
  puts "#{source}:"
  last_rec = db.get_latest_ts ({'type' => type, 'source' => source})
  feed.get_data.each do |item|
    if last_rec.to_a.size == 0 || item['date'].to_i > last_rec['date']
      item['guid'] = Digest::MD5.hexdigest(sanitize item['guid'])
      item['type'] = type
      item['source'] = source
      db.update_rec item
    end
  end
end
