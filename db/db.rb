require 'mongo'
require 'rubygems'

include Mongo

class Db
  @@host = 'ds053469.mongolab.com'
  @@user = 'kyojin'
  @@pass = 'kyojin123'
  @@port = '53469'
  @@db = 'kyojin'
  @@collection_name = 'feeds'
  
  def initialize
    client = MongoClient.new(@@host, @@port)
    db = client.db(@@db)
    db.authenticate(@@user, @@pass)
    @@collection = db.collection(@@collection_name)
  end

  def get_latest_ts condition
    return @@collection.find( condition, {:fields => 'date'}).sort({ 'date' => -1 }).limit(1).first
  end

  def update_rec item
    @@collection.update({'guid' => item['guid']}, item , {:upsert => :true})
  end

end
