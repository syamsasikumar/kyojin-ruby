require 'sanitize'
require 'htmlentities'
Dir['./**/*.rb'].each{ |f| require f }

def sanitize text
  return Sanitize.fragment(text).split.join(' ')
end

consumer_types = ['bbc', 'sky', 'dm', 'times', 'guardian']

consumer_factory = ConsumerFactory.new
consumer_types.each do |type|
  feed = consumer_factory.get_feed type
  puts "#{type}:"
  feed.get_data.each do |item|
    puts sanitize item['title']
    puts sanitize item['description']
    puts item['thumbnail']
    puts item['date']
  end
end