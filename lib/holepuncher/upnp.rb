require "UPnP"

module Holepuncher
  class UPNPGateway
    def initialize
      begin
        @upnp = UPnP::UPnP.new(true, false)
        @upnp.discoverIGD
      rescue UPnP::UPnPException => e
        raise GatewayNotFound, "UPnP gateway not found: #{e.inspect}"
      end
    end

    def protocol(proto)
      if proto == :tcp
        UPnP::Protocol::TCP
      elsif proto == :udp
        UPnP::Protocol::UDP
      else
        raise "unknown protocol"
      end
    end

    def map(port, proto)
      tried_delete = false
      begin
        @upnp.addPortMapping(port, port, protocol(proto), "toryp")
      rescue UPnP::UPnPException
        if !tried_delete
          unmap(port, proto)
          tried_delete = true
          retry
        else
          raise FailedToMap, "Failed to map port #{port} over #{proto}. The port may conflict with an existing mapping"
        end
      end
    end

    def unmap(port, proto)
      @upnp.deletePortMapping(port, protocol(proto))
    rescue => e
      # most common error would probably be that it was already unmapped,
      # but having some error logging here might be good anyway
    end

    def ext_ip
      @upnp.externalIP
    end
  end
end
