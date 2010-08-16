
require "rubygems"
require "bundler"
Bundler.setup

require 'haml'
require 'sinatra'
require 'open-uri'
require 'yajl'
require 'rufus-json'

get '/' do
  redirect '/nameplate/jmettraux'
end

get '/nameplate/:twitterid' do

  @id = params[:twitterid]

  info = open("http://twitter.com/users/#{@id}.json").read rescue nil
  info = Rufus::Json.decode(info)
  #puts Rufus::Json.pretty_encode(info)

  @name = info['name']
  @image = info['profile_image_url']

  content_type 'text/html', :charset => 'utf-8'
  haml :nameplate
end

