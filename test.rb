require 'data_mapper'
require 'will_paginate'
require 'will_paginate/data_mapper'
class User
  include DataMapper::Resource

  property :id,   Serial    # primary serial key
  property :username, String, length: 5..15, unique: true
  property :fullname, String, length: 5..25
  property :email, String, required: true, unique: true, format: :email_address
  property :hashed_password, String
  property :created_at, Time, required: true
  property :auth_token, String
  property :locale, String

  has n, :items
end

class Item
  include DataMapper::Resource
  property :id, Serial
  property :question, String, required: true
  property :answer, String, required: true
  property :ef, Float
  property :interval, Float
  property :created_at, Time
  property :updated_at, Time
  property :reviev_at, Time

  belongs_to :user
end

DataMapper::setup(:default, "sqlite3://#{File.expand_path(File.dirname(__FILE__))}/database2.db")
DataMapper.finalize
DataMapper.auto_upgrade!

u = User.first
p = u.items.paginate(page: 1)
puts p.total_entries
