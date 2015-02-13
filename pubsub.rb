require 'active_support/all'
require 'bunny'

class Pubsub
  def self.publish(event, data)
    payload = {data: data, event: event}.stringify_keys

    connection = Bunny.new
    connection.start;

    channel = connection.create_channel;

    x = channel.fanout('users');
    x.publish(payload.to_json)
  
    p "published: #{payload.to_json}"
  end
end


user = {name: 'Imran', age: 29, location: 'Ann Arbor', company: 'MB Financial'}
message = "A new user has joined!"
Pubsub.publish('new-user', {user: user, message: message })
