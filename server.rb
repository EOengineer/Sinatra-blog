require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/assetpack'
require_relative 'lib/models/blog'
require 'pry'
require 'json'


get '/' do
  erb :admin_layout, layout: false do
    erb :index
  end
end

get '/admin/blogs' do
  @blogs = Blog.all
  erb :admin_layout, layout: false do
    erb :"admin/blogs/index"
  end
end

get "/admin/blogs/new" do
  @blog = Blog.new
  erb :admin_layout, layout: false do
    erb :"/admin/blogs/new"
  end

end


post "/admin/blogs" do
  @blog = Blog.new(params[:blog])

  if @blog.save
    redirect "/admin/blogs/#{@blog.id}"
    flash[:success] = "Blog was successfully added!"
  else
    erb :admin_layout, layout: false do
      erb :"/admin/blogs/new"
    end
  end
end

get '/admin/blogs/:id' do
  @blog = Blog.find(params[:id])
  erb :admin_layout, layout: false do
    erb :"admin/blogs/show"
  end
end



get '/api/blogs' do
  content_type :json
  @blogs = Blog.all.to_json
end

get '/api/blogs/:id' do
  content_type :json
  @blog = Blog.find(params[:id]).to_json
end






configure :development do
  set :database, {adapter: "sqlite3", database: "blog.sqlite3"}
end

configure :test do
  set :database, {adapter: "sqlite3", database: "blog-test.sqlite3"}
end

