require 'keyline/connection'
require 'keyline/writeable'
require 'keyline/resource'
require 'keyline/collection'
require 'keyline/errors'

require 'keyline/resources/order'
require 'keyline/resources/product'
require 'keyline/resources/component'
require 'keyline/resources/finishing'
require 'keyline/resources/finishing_property'

module Keyline
  class Client
    include Keyline::Connection
  end
end
