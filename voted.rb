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
  vote_id = params[:id]

  vote = Vote.find_or_initialize_by(id: vote_id)

  vote.count += 1
  vote.save!

  "Count updated!"
end

get '/' do
  @votes = Vote.all.order(:id)
  haml :index
end

