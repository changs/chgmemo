class User
  include DataMapper::Resource

  property :id,   Serial    # primary serial key
  property :username, String, required: true
  property :fullname, String, required: true
  property :email, String, required: true
  property :password, String, required: true
  property :created_at, DateTime, required: true
  property :auth_token, String
  property :locale, String
end

class Item
  include DataMapper::Resource
  property :id, Serial
  property :question, String, required: true
  property :answer, String, required: true
  property :ef, Float
  property :interval, Float
  property :created_at, DateTime
  property :updated_at, DateTime
  property :reviev_at, DateTime
end

class Stat
  include DataMapper::Resource
  property :avarage_grade, Float
  property :avarage_items_per_day, Float
end
