require 'sinatra'
require 'active_record'

require 'pg'
require 'haml'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'postgres',
  user: 'postgres',
  pool: 5
)

class Vote < ActiveRecord::Base
end

after do
  ActiveRecord::Base.clear_active_connections!
end

post '/vote' do
  vote_name = params[:name]

  vote = Vote.find_or_create_by(name: vote_name)

  vote.count += 1
  vote.save!

  "Count updated!"
end

get '/' do
  @votes = Vote.all.order(:id)
  haml :index
end

