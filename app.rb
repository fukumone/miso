require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra-websocket'
require './config/environments'

class MisoApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set :server, 'thin'
  set :sockets, []

  get '/' do
    if !request.websocket?
      erb :index
    else
      request.websocket do |ws|
        ws.onopen do
          ws.send("Hello World!")
          settings.sockets << ws
        end
        ws.onmessage do |msg|
          EM.next_tick { settings.sockets.each{|s| s.send(msg) } }
        end
        ws.onclose do
          warn("websocket closed")
          settings.sockets.delete(ws)
        end
      end
    end
  end

end
