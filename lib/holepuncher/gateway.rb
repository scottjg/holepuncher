module Holepuncher
  class Gateway
    def self.discover
      # speed this up by remembering the last successful
      # gateway type, and trying that first
      next_type = @last_type || :natpmp

      @upnp = @natpmp = nil
      while @upnp.nil? || @natpmp.nil?
        if next_type == :upnp
          begin
            @upnp = UPNPGateway.new
          rescue GatewayNotFound
            @upnp = :nope
            next_type = :natpmp
            next
          end
          @last_type = :upnp
          return @upnp
        elsif next_type == :natpmp
          begin
            @natpmp = NATPMPGateway.new
          rescue GatewayNotFound
            @natpmp = :nope
            next_type = :upnp
            next
          end
          @last_type = :natpmp
          return @natpmp
        end
      end
      raise GatewayNotFound, "No UPnP/NAT-PMP gateway found!"
    end
  end
end