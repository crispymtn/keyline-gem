require 'keyline/connection'
require 'keyline/resource'
require 'keyline/collection'
require 'keyline/errors'
require 'keyline/writeable'

require 'keyline/resources/order'
require 'keyline/resources/product'

module Keyline
  class Client
    include Keyline::Connection
  end
end
