#!/usr/bin/ruby
require 'sender'
require 'listener'

class Multicast

  def self.start
    addr_list = create_address_list
    @listeners = launch_listeners(addr_list)
    @sender = Sender.new
    @sender.start_sending(addr_list)
  end

  def self.stop
	@sender.stop_sending
	stop_listening(@listeners)
  end
	
  private
  
  def self.create_address_list
    addresses = []
    ARGV.each_slice(2) do |i|
      addresses << i
    end
    return addresses
  end

  def self.launch_listeners(addr_list)
    listener_list = []
    addr_list.each do |address|
      listener = Listener.new(address[0].to_s, address[0]) #0==ip, 1==port
      listener.listen
      listener_list << listener
    end
    return listener_list
  end
  
  def stop_listening(listener_list)
	listener_list.each do |i|
		i.stop_listening
	end
  end

end

Multicast.start
Multicast.stop
