require ::File.expand_path('config/sinatra',  File.dirname(__FILE__))

map '/assets/' do
  run settings.sprockets
end

map '/' do
  run Sinatra::Application
end