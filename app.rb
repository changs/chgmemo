require 'sinatra'
require 'rack-flash'
require 'haml'
require "sinatra/cookies"
require 'gchart'
require 'date'
require 'sinatra/r18n'

set :public_folder, File.dirname(__FILE__) + '/static'
set :haml, :format => :html5
use Rack::Session::Pool, :expire_after => 2592000
use Rack::Flash



before do
  @title = "ChgMemo"
  session[:locale] ||= Locale.get(1)
  session[:locale] = Locale.get(current_user.locale) if logged_in?
end

before '/item/*' do
  authorized?
end

before '/admin*' do
  admin!
end

require './helpers/helpers'
require './db.rb'

# authentication
get '/user/create' do
  @user = User.new
  haml :create
end

post '/user/create' do
  u = User.new
  u.username = h params["username"]
  u.fullname = h params["fullname"]
  u.email = h params["email"]
  u.password = h params["password"]
  u.locale = Locale.first(code: params["locale"]).id
  if u.save
    flash[:notice_type], flash[:notice] = "success", t.user.created
    sign_in(u)
    redirect '/'
  else
    flash[:notice_type], flash[:notice] = "error", u.errors.full_messages.join("<br/>")
    redirect '/user/create'
  end
end

get '/user/edit' do
  authorized?
  @user = current_user
  haml :create
end

post '/user/update' do
  if current_user.update(username: (params['username']), fullname: (params["fullname"]), email: (params["email"]), locale: Locale.first(code: params["locale"]).id)
    flash[:notice_type], flash[:notice] = "success", t.user.updated
    redirect '/'
  else
    flash[:notice_type], flash[:notice] = "error", current_user.errors.full_messages.join("<br/>")
    redirect '/user/edit'
  end
end

get '/user/delete' do
  authorized?
  haml :delete
end

get '/user/delete2' do
  authorized?
  current_user.items.destroy!
  current_user.destroy!
  cookies.delete(:auth_token)
  current_user = nil
  flash[:notice_type], flash[:notice] = "success", t.user.deleted
  redirect '/'
end

get '/user' do
  authorized?
  @user = current_user
  haml :user
end

get '/login' do
  haml :login
end

post '/login' do
  if u = User.authenticate(params["username"], params["password"])
    sign_in(u)
    session[:locale] = Locale.get(current_user.locale)
    flash[:notice_type], flash[:notice] = "success", "#{t.hello} #{params['username']}"
    redirect '/'
  else
    flash[:notice_type], flash[:notice] = "error", t.user.login_failed
    redirect '/login'
  end
end

get '/logout' do
  cookies.delete(:auth_token)
  current_user = nil
  flash[:notice_type], flash[:notice] = "success", t.user.logout_success 
  redirect '/'
end
# end of authentication

get '/' do
  #@news = News.all(language: session[:locale])
  @news = News.all(locale: session[:locale].id)
  haml :index
end

get '/items' do
  authorized?
  @items = current_user.items 
  haml :'items/index'
end

get '/item/create' do
  @item = Item.new
  haml :"items/_item_form"
end

post '/item/create' do
  i = current_user.items.new
  i.question = h params["question"]
  i.answer = h params["answer"]
  if i.save
    flash[:notice_type], flash[:notice] = "success", t.item.created
    redirect '/items'
  else
    flash[:notice_type], flash[:notice] = "error",  i.errors.full_messages.join("<br/>")
    redirect '/item/create'
  end
end

get '/item/:id' do
  @item = current_user.items.get(params[:id])
  haml :'items/item'
end

get '/item/:id/edit' do
  @item = current_user.items.get(params[:id])
  haml :'items/_item_form'
end

post '/item/:id/edit' do
  i = current_user.items.get(params[:id])
  i.question = h params["question"]
  i.answer = h params["answer"]
  if i.update
    flash[:notice_type], flash[:notice] = "success", t.item.updated
    redirect '/items'
  else
    flash[:notice_type], flash[:notice] = "error",  i.errors.full_messages.join("<br/>")
    redirect '/item/create'
  end
end

get '/item/:id/delete' do
  current_user.items.get(params[:id]).destroy!
  flash[:notice_type], flash[:notice] = "success", t.item.deleted
  redirect '/items'
end

get '/review' do
  authorized?
  @item = Item.next_review_item(current_user)
  unless @item.nil?
    haml :'/items/review'
  else
    flash[:notice_type], flash[:notice] = "success", t.item.no_items
    redirect '/'
  end
end

post '/item/:id/review' do
  grades = { t.item.grades.ideal => 5, t.item.grades.good => 4, t.item.grades.pass => 3,
    t.item.grades.Bad => 2, t.item.grades.none => 1 }
  el = Item.get(params[:id])
  el.update_ef(grades[params[:commit]])
  el.save
  el.update
  redirect '/review'
end

get '/admin' do
  haml :'admin/index' 
end

get '/admin/add_news' do
  @news = News.new
  haml :'admin/add_news'
end

post '/admin/create_news' do
  p = News.new
  p.title = params["title"]
  p.content = params["content"]
  p.locale = Locale.first(code: params["locale"]).id
  p.save
  flash[:notice_type], flash[:notice] = "success", "News has been posted."
  redirect '/admin'
end

get '/admin/users' do
  @users = User.all
  haml :'admin/users'
end

get '/admin/user_delete/:id' do
  User.get(params[:id]).items.destroy!
  User.get(params[:id]).destroy!
  flash[:notice_type], flash[:notice] = "success", "User deleted."
  redirect '/admin/users'
end

get '/admin/user_admin/:id' do
  User.get(params[:id]).update(admin: true)
  flash[:notice_type], flash[:notice] = "success", "User marked as admin."
  redirect '/admin/users'
end

get '/en' do
  session[:locale] = Locale.first(code: 'en')
  redirect back
end

get '/pl' do
 session[:locale] = Locale.first(code: 'pl')
 redirect back
end
