# The call of run method is inside the required file
require ::File.expand_path('../sinatra',  __FILE__)

use Rack::ShowExceptions

map '/assets' do
  run settings.sprockets
end

map '/' do
  run Sinatra::Application
end