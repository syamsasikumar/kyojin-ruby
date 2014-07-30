#fetches tweets from twitter list and sends to mongo lab
require 'twitter'
Dir['./db/*.rb'].each{ |f| require f }

config = {
  :consumer_key    => 'NDgCko1AR7hmGjioSUzS0UOdV',
  :consumer_secret => 'ed7QesMP0yJXS45H4DcezqxsKibNzpriA5ZAcowuQsUWqlSRGP',
}
type = 'tweet'
user_file = './twitter_list'

client = Twitter::REST::Client.new(config)
db = Db.new

File.open(user_file).each do |source|
  puts source
  timeline = client.user_timeline(source, :count => 50 )
  user = client.user(source)
  last_rec = db.get_latest_ts ({'type' => type, 'source' => source})
  #puts last_rec['date']
  timeline.each do |t|
    if last_rec.to_a.size == 0 || t.created_at.to_i > last_rec['date']
      title = '@' + source + ' : ' + t.text
      item = {}
      item['guid'] = t.id.to_s
      item['type'] = type
      item['source'] = source
      item['title'] = title
      item['description'] = t.text
      item['thumbnail'] = user.profile_image_url.to_s
      item['link'] = t.url.to_s 
      item['date'] = t.created_at.to_i 
      db.update_rec item
      puts item['date']
   end
  end
end


