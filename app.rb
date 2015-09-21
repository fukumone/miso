require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra-websocket'
require './config/environments'
require './models/message.rb'

class MisoApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set :server, 'thin'
  set :sockets, []

  get '/' do
    @messages = Message.order(created_at: :desc)
    if !request.websocket?
      erb :index
    else
      request.websocket do |ws|
        ws.onopen do
          ws.send("Hello World!")
          settings.sockets << ws
        end
        ws.onmessage do |msg|
          @message = Message.new(content: msg)

          if @message.save
            EM.next_tick { settings.sockets.each{|s| s.send(msg) } }
          end
        end
        ws.onclose do
          warn("websocket closed")
          settings.sockets.delete(ws)
        end
      end
    end
  end

end
