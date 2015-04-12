require 'sinatra'
require 'sinatra/activerecord'
require_relative 'lib/models/blog'


get '/' do
  erb :index
end

get "/blogs/new" do
  erb :"blogs/new"
end

configure do
  set :database, {adapter: "sqlite3", database: "blog.sqlite3"}
end
