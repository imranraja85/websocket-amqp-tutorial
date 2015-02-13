require 'em-websocket'
require 'bunny'
    
EventMachine::WebSocket.start(:host => "0.0.0.0", :port => '3003') do |ws|
  ws.onopen do
    p 'websocket opened'
        
    connection = Bunny.new
    connection.start
        
    channel = connection.create_channel;
    x = channel.fanout('users')
    q = channel.queue("", :auto_delete => true).bind(x)
 
    q.subscribe do |delivery_info, metadata, payload|
      ws.send payload
    end 
  end
      
  ws.onmessage do |message|
    p "received message: #{message}"
  end
      
  ws.onclose do
    p 'websocket closed'
  end
end
