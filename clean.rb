#remove old records
Dir['./db/*.rb'].each{ |f| require f }
require 'date'

db = Db.new
two_weeks_back = Time.now.to_i - 60 * 60 * 24 * 14 

db.remove_old_recs two_weeks_back