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
require 'keyline/resources/user'
require 'keyline/resources/person'
require 'keyline/resources/organization'
require 'keyline/resources/assignment'
require 'keyline/resources/order'
require 'keyline/resources/print_data_file'
require 'keyline/resources/print_data_erratum'
require 'keyline/resources/product'
require 'keyline/resources/packaging'
require 'keyline/resources/pick'
require 'keyline/resources/shipment'
require 'keyline/resources/shipment_address'
require 'keyline/resources/address'
require 'keyline/resources/production_flow_modification'
require 'keyline/resources/production_path'
require 'keyline/resources/imposing'
require 'keyline/resources/master_signature'
require 'keyline/resources/signature'
require 'keyline/resources/component'
require 'keyline/resources/finishing'
require 'keyline/resources/finishing_property'
require 'keyline/resources/variant'
require 'keyline/resources/circulation'
require 'keyline/resources/substrate'
require 'keyline/resources/desired_paper_properties'
require 'keyline/resources/material'
require 'keyline/resources/material_quote'
require 'keyline/resources/material_storage_area'
require 'keyline/resources/material_preset'
require 'keyline/resources/stock_finishing'
require 'keyline/resources/stock_substrate'
require 'keyline/resources/stock_product'
require 'keyline/resources/supplier'
require 'keyline/resources/supplier_contact'
require 'keyline/resources/parcel'

module Keyline
  class Client
    attr_reader :connection
    delegate :perform_request, to: :connection

    def initialize(options = {})
      @connection = Keyline::Connection.new(options)
    end

    def connection_valid?
      perform_request(:get, 'configuration/printery') ? true : false
    end
  end
end
