require 'twitter'

config = {
  :consumer_key    => 'NDgCko1AR7hmGjioSUzS0UOdV',
  :consumer_secret => 'ed7QesMP0yJXS45H4DcezqxsKibNzpriA5ZAcowuQsUWqlSRGP',
}

client = Twitter::REST::Client.new(config)


timeline = client.user_timeline('manutd', :count => 200 )
user = client.user('manutd')
timeline.each do |t|
	puts t.text
	puts t.id.to_s
	puts t.url
	puts t.created_at
	puts user.profile_image_url
end
