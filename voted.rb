require 'sinatra'
require 'sequel'

require 'tilt/haml'
require 'pg'

Sequel.connect(
  adapter: 'postgresql',
  database: 'postgres',
  user: 'postgres',
  pool: 5
)

class Vote < Sequel::Model
end

after do
end

post '/vote' do
  vote_id = params[:id]

  vote = Vote.where(id: vote_id).first

  vote.count += 1
  vote.save

  "Count updated!"
end

get '/' do
  @votes = Vote.order(:id).all
  haml :index
end

