require 'sinatra'
require 'sinatra/activerecord'
require_relative 'lib/models/blog'
require 'pry'


get '/' do
  erb :index
end

get '/blogs' do
  @blogs = Blog.all
  erb :"blogs/index"
end

get "/blogs/new" do
  @blog = Blog.new
  erb :"blogs/new"
end


post "/blogs" do
  @blog = Blog.new(params[:blog])

  if @blog.save
    redirect "blogs/#{@blog.id}"
  else
    erb :"blogs/new"
  end
end

get '/blogs/:id' do
  @blog = Blog.find(params[:id])
  erb :"blogs/show"
end






configure do
  set :database, {adapter: "sqlite3", database: "blog.sqlite3"}
end

