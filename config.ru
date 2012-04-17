require ::File.expand_path('config/sinatra',  File.dirname(__FILE__))

map '/' do
  # run App
  run Sinatra::Application
end