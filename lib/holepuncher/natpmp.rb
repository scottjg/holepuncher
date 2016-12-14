require "natpmp"

module Holepuncher
  class NATPMPGateway
    def initialize
      begin
        ext_ip
      rescue
        raise GatewayNotFound, "NAT-PMP gateway not found!"
      end
    end

    def map(port, proto)
      tried_delete = false
      begin
        map = NATPMP.new(port, port, 3600, proto)
        map.request!
        if map.priv != port || map.mapped != port
          raise FailedToMap, "Failed to map port #{port} over #{proto}. The port may conflict with an existing mapping"
        end
      rescue
        if !tried_delete
          unmap(port, proto)
          tried_delete = true
          retry
        else
          raise
        end
      end
    end

    def unmap(port, proto)
      map = NATPMP.new(port, port, 3600, proto)
      map.revoke!
    rescue => e
      # most common error would probably be that it was already unmapped,
      # but having some error logging here might be good anyway
    end

    def ext_ip
      NATPMP.addr
    end

    def gateway_type
      "NAT-PMP"
    end
  end
end
