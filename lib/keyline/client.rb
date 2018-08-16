require 'vendor/box'

require 'jeweler/client'
require 'jeweler/connection'
require 'jeweler/writeable'
require 'jeweler/resource'
require 'jeweler/singleton_resource'
require 'jeweler/finders'
require 'jeweler/collection'
require 'jeweler/errors'

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
require 'keyline/resources/shipment'
require 'keyline/resources/shipment_address'
require 'keyline/resources/parcel'
require 'keyline/resources/logistics/shipment'
require 'keyline/resources/production/product'
require 'keyline/resources/production/print_data_file'
require 'keyline/resources/production/packaging'
require 'keyline/resources/production/production_path'
require 'keyline/resources/production/component'
require 'keyline/resources/production/finishing'
require 'keyline/resources/production/variant'
require 'keyline/resources/production/material_preset'
require 'keyline/resources/production/stock_finishing'
require 'keyline/resources/production/substrate'
require 'keyline/resources/production/imposing'
require 'keyline/resources/production/master_signature'
require 'keyline/resources/production/signature'
require 'keyline/resources/production/material_demand'
require 'keyline/resources/production/task'

module Keyline
  class Client
    include Jeweler::Client

    base_collections :parcels, :orders, :organizations, :people, :materials, :material_storage_areas,
      :stock_substrates, :stock_finishings, :stock_products


    def initialize(options = {})
      super(host: options[:host], token: options[:token], base_uri: '/api/v2/')
    end

    def printery
      @printery ||= Keyline::Printery.new(self, self.perform_request(:get, Keyline::Printery.path))
    end


    def production_products
      Jeweler::Collection.new(
        self,
        -> { self.perform_request(:get, Keyline::Production::Product.path_for_index(nil)) },
        Keyline::Production::Product
      )
    end

    def logistics_shipments
      Jeweler::Collection.new(
        self,
        -> { self.perform_request(:get, Keyline::Logistics::Shipment.path_for_index(nil)) },
        Keyline::Logistics::Shipment
      )
    end
  end
end
