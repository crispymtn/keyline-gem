require 'keyline/connection'
require 'keyline/writeable'
require 'keyline/resource'
require 'keyline/collection'
require 'keyline/errors'

require 'keyline/resources/order'
require 'keyline/resources/product'
require 'keyline/resources/production_path'
require 'keyline/resources/production_junction'
require 'keyline/resources/master_signature'
require 'keyline/resources/signature'
require 'keyline/resources/component'
require 'keyline/resources/finishing'
require 'keyline/resources/finishing_property'

module Keyline
  class Client
    include Keyline::Connection
  end
end
