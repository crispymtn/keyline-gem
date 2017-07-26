require 'keyline/connection'
require 'keyline/resource'
require 'keyline/collection'

require 'keyline/order'

module Keyline
  class Client
    include Keyline::Connection
  end
end
