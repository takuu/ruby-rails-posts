require 'net/http'
require 'json'

#$url = 'https://graph.facebook.com/CocaColaUnitedStates/posts?fields=likes.limit(0).summary(true),id,created_time,message&access_token=EAACEdEose0cBALKvJoeLnMXLg8AoeMC2tK99kDZBLLeOXmBAjWXUCX6zINtLQlFZAgAVWgoWpbTzAsObuOtUGCxVkiVeNlv9OJ4SkxlxxgIC0ge3wcAzAqVWNKgJZBJ0sIfv9Gn1ZBxRdCQ2DmZBHZC9qFkLFBZC93L09pdwSHE2sWme4ZBD2CTH10DoX7kFvP0ZD'
$access_token = 'EAACEdEose0cBALKvJoeLnMXLg8AoeMC2tK99kDZBLLeOXmBAjWXUCX6zINtLQlFZAgAVWgoWpbTzAsObuOtUGCxVkiVeNlv9OJ4SkxlxxgIC0ge3wcAzAqVWNKgJZBJ0sIfv9Gn1ZBxRdCQ2DmZBHZC9qFkLFBZC93L09pdwSHE2sWme4ZBD2CTH10DoX7kFvP0ZD'
$app_list = ['CocaColaUnitedStates', 'fcbarcelona', 'WholeFoods']

class ProductsController < ApplicationController
  def index

    total_return = params[:TOP_POSTS_COUNT] || ''
    limit = params[:MAX_POSTS_PER_PAGE] || 5
    puts "limit: " + limit
    list = []
    $app_list.each do |app_id|
      uri = URI('https://graph.facebook.com/' + app_id + '/posts?' + 'limit=' + limit + '&fields=likes.limit(0).summary(true),id,created_time,message&access_token=' + $access_token)
      response = Net::HTTP.get(uri)
      result = JSON.parse(response)
      list =  list + result['data']
      # puts result['data'][0]
    end
    @products = list.sort_by { |hash| hash['likes']['summary']['total_count'] }.reverse
    render json: { status: 200,
    data: @products[0..total_return.to_i] }
  end
end
