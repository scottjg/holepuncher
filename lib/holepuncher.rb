require "holepuncher/gateway"
require "holepuncher/natpmp"
require "holepuncher/upnp"
require "holepuncher/version"

module Holepuncher
  class GatewayNotFound < StandardError; end
  class FailedToMap < StandardError; end
end
