require ::File.expand_path('../sinatra',  __FILE__)

map '/assets' do
  run settings.sprockets
end

map '/' do
  run Sinatra::Application
end