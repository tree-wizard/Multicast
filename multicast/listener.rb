require 'socket'
require 'ipaddr'

class Listener

  @@bind_addr = "0.0.0.0" 
  attr_accessor :ip, :port

  def initialize(ip, port)
    @ip = ip.to_s
    @port = port
    membership = IPAddr.new(@ip).hton + IPAddr.new(@@bind_addr).hton
    @socket = UDPSocket.new
    @socket.setsockopt(:IPPROTO_IP, :IP_ADD_MEMBERSHIP, membership)
    @socket.bind(@@bind_addr, @port)

    loop do
      message, info = @socket.recvfrom(1024)
      STDOUT.puts(message + " " + time.to_s)
    end
  end
  
  def stop
	@socket.close
	STDOUT.puts("listener at ip #{@ip} and port #{@port} is closed")
  end

  def time
    Time.now.to_i
  end

end
