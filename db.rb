require 'data_mapper'
require 'digest/sha1'
require './helpers/sinatra'

class User
  include DataMapper::Resource

  property :id,   Serial    # primary serial key
  property :username, String, length: 5..15, unique: true, format: /\A[a-z0-9_-]+\z/i
  property :fullname, String, length: 5..25, format: /\A[a-z0-9_-]+\z/i
  property :email, String, required: true, unique: true, format: :email_address
  property :hashed_password, String
  property :created_at, Time
  property :auth_token, String
  property :locale, Integer
  property :admin, Boolean

  attr_accessor :password

  validates_presence_of :hashed_password

  has n, :items 

  before :create, :set_created_at

  def set_created_at(context = :default)
    self.created_at = Time.now
  end

  def password=(pass)
    @password = pass
    self.auth_token = Helpers::random_string(20) unless self.auth_token
    self.hashed_password = User.encrypt(@password, self.auth_token)
  end

  def self.encrypt(pass, auth_token)
    Digest::SHA1.hexdigest(pass + auth_token)
  end

  def self.authenticate(username, pass)
    u = User.first(username: username)
    return nil if u.nil?
    return u if User.encrypt(pass, u.auth_token) == u.hashed_password
    nil
  end
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
  property :review_at, Time

  attr_accessor :grade

  belongs_to :user

  before :valid?, :set_default_attr

  def set_default_attr
    self.ef = 2.2
    self.interval = 1
    self.review_at = (Time.now + 60*60*24)
  end

  def update_ef(grade)
    self.ef = self.ef+(0.1-(5-grade)*(0.08+(5-grade)*0.02))   # Supermemo 2.0 Algorithm
    self.ef = 1.3 if self.ef < 1.3
    if self.interval <= 1 and grade >= 3
      self.interval = 3
    elsif (self.interval != 1 ) and (grade >= 3)
      self.interval = self.interval * self.ef
    else
      self.interval = 0
    end
    self.review_at = self.updated_at + (self.interval)*24*60*60
    self.updated_at = Time.now
  end

  def self.next_review_item (user)
    items = user.items.all(:review_at.lt => Time.now)
    return items[rand(items.size)] unless items.empty?
  end
end

class News
  include DataMapper::Resource
  property :id, Serial
  property :created_at, Time
  property :title, String
  property :content, Text
  property :locale, Integer
  before :valid?, :set_default_attr
  def set_default_attr
    self.created_at = Time.now
  end

end

class Locale
  include DataMapper::Resource
  property :id, Serial
  property :code, String, length: 2

end

#DataMapper::setup(:default, "sqlite3://#{File.expand_path(File.dirname(__FILE__))}/database.db")
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
DataMapper.finalize
DataMapper.auto_upgrade!

Locale.first_or_create(code: 'en')
Locale.first_or_create(code: 'pl')
