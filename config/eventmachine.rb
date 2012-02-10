require 'rubygems'
require 'bundler/setup'
require 'eventmachine'
require 'em-websocket'

@sockets = []
EventMachine.run do
  EventMachine::WebSocket.start(:host => '127.0.0.0', :port => 8888) do |socket|
    socket.onopen do
      @sockets << socket
    end
    socket.onmessage do |message|
      @sockets.each { |s| s.send message }
    end
    socket.onclose do
      @sockets.delete socket
    end
  end
end