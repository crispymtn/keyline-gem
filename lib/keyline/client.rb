require 'vendor/box'

require 'keyline/connection'
require 'keyline/writeable'
require 'keyline/resource'
require 'keyline/singleton_resource'
require 'keyline/finders'
require 'keyline/collection'
require 'keyline/errors'
require 'keyline/inflections'

require 'keyline/resources/printery'
require 'keyline/resources/order'
require 'keyline/resources/print_data_file'
require 'keyline/resources/print_data_erratum'
require 'keyline/resources/product'
require 'keyline/resources/packaging'
require 'keyline/resources/pick'
require 'keyline/resources/shipment'
require 'keyline/resources/address'
require 'keyline/resources/production_path'
require 'keyline/resources/production_junction'
require 'keyline/resources/master_signature'
require 'keyline/resources/signature'
require 'keyline/resources/component'
require 'keyline/resources/finishing'
require 'keyline/resources/finishing_property'
require 'keyline/resources/variant'
require 'keyline/resources/circulation'
require 'keyline/resources/paper'
require 'keyline/resources/desired_paper_properties'
require 'keyline/resources/material'
require 'keyline/resources/material_quote'
require 'keyline/resources/stock_finishing'
require 'keyline/resources/stock_paper'
require 'keyline/resources/stock_product'
require 'keyline/resources/supplier'
require 'keyline/resources/supplier_contact'

module Keyline
  class Client
    include Keyline::Connection
  end
end
