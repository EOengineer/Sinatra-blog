require 'sinatra'
require 'sinatra/activerecord'
require_relative 'lib/models/blog'
require 'pry'


get '/' do
  erb :index
end

get '/admin/blogs' do
  @blogs = Blog.all
  erb :"admin/blogs/index"
end

get "/admin/blogs/new" do
  @blog = Blog.new
  erb :"/admin/blogs/new"
end


post "/admin/blogs" do
  @blog = Blog.new(params[:blog])

  if @blog.save
    redirect "/admin/blogs/#{@blog.id}"
  else
    erb :"admin/blogs/new"
  end
end

get '/admin/blogs/:id' do
  @blog = Blog.find(params[:id])
  erb :"admin/blogs/show"
end






configure do
  set :database, {adapter: "sqlite3", database: "blog.sqlite3"}
end

