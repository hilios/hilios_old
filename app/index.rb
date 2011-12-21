# require 'sinatra/contrib/all'
require 'haml'

before do
  
end

get '/' do
  "Test #{settings.root} #{}"
end