require 'socket'

class Sender

  def initialize
    @socket = UDPSocket.open
    @socket.setsockopt(:IPPROTO_IP, :IP_MULTICAST_TTL, 1)
  end

  def start_sending(addr_list)
	200.times do
	  sleep(0.5)
      addr_list.each do |i|
        send_message(i)
      end
	end
  end
  
  def stop_sending
	@socket.close
  end
  
  def send_message(address)
    @socket.send(time.to_s, 0, address[0].to_s, address[1]) #0==ip, 1==port
  end

  private
  
  def time
    Time.now.to_i
  end
  
end
