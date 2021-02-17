require 'active_support/security_utils'
require 'vendor/box'

require 'jeweler/client'
require 'jeweler/connection'
require 'jeweler/writeable'
require 'jeweler/resource'
require 'jeweler/singleton_resource'
require 'jeweler/finders'
require 'jeweler/collection'
require 'jeweler/errors'

require 'keyline/errors'
require 'keyline/event'

require 'keyline/resources/printery'
require 'keyline/resources/document_callback'
require 'keyline/resources/means_of_production'
require 'keyline/resources/user'
require 'keyline/resources/person'
require 'keyline/resources/organization'
require 'keyline/resources/address_announcement'
require 'keyline/resources/assignment'
require 'keyline/resources/business_unit'
require 'keyline/resources/carrier'
require 'keyline/resources/order'
require 'keyline/resources/print_data_file'
require 'keyline/resources/print_data_erratum'
require 'keyline/resources/product'
require 'keyline/resources/packaging'
require 'keyline/resources/pick'
require 'keyline/resources/address'
require 'keyline/resources/origin_address'
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
require 'keyline/resources/desired_substrate_properties'
require 'keyline/resources/material'
require 'keyline/resources/material_quote'
require 'keyline/resources/material_storage_area'
require 'keyline/resources/material_preset'
require 'keyline/resources/stock_finishing'
require 'keyline/resources/stock_substrate'
require 'keyline/resources/stock_color'
require 'keyline/resources/stock_folding_pattern'
require 'keyline/resources/stock_product'
require 'keyline/resources/shipment'
require 'keyline/resources/parcel'
require 'keyline/resources/stock_task'
require 'keyline/resources/raw_material_requirement'
require 'keyline/resources/processing_requirement'
require 'keyline/resources/task'
require 'keyline/resources/material_demand'
require 'keyline/resources/production/product'
require 'keyline/resources/production/print_data_file'
require 'keyline/resources/production/packaging'
require 'keyline/resources/production/selected_production_path'
require 'keyline/resources/production/component'
require 'keyline/resources/production/finishing'
require 'keyline/resources/production/finishing_property'
require 'keyline/resources/production/variant'
require 'keyline/resources/production/material_preset'
require 'keyline/resources/production/stock_finishing'
require 'keyline/resources/production/substrate'
require 'keyline/resources/production/imposing'
require 'keyline/resources/production/master_signature'
require 'keyline/resources/production/signature'
require 'keyline/resources/production/material_demand'
require 'keyline/resources/production/task'
require 'keyline/resources/production/task_execution'
require 'keyline/resources/production/means_of_production'
require 'keyline/resources/production/order'
require 'keyline/resources/production/customer'
require 'keyline/resources/production/sheet'
require 'keyline/resources/invoice'
require 'keyline/resources/customer_invoice'
require 'keyline/resources/credit_note'
require 'keyline/resources/reversal_invoice'
require 'keyline/resources/recipient'
require 'keyline/resources/contact'
require 'keyline/resources/line_item'
require 'keyline/resources/accounting_category'
require 'keyline/resources/payment_term'

module Keyline
  class Client
    include Jeweler::Client

    base_collections :parcels, :orders, :organizations, :people, :materials, :material_storage_areas,
      :stock_substrates, :stock_finishings, :stock_products, :stock_tasks, :stock_colors,
      :stock_folding_patterns, :business_units, :invoices, :customer_invoices, :credit_notes,
      :reversal_invoices, :users, :products

    def initialize(options = {})
      super(
        host: options[:host],
        token: options[:token],
        base_uri: '/api/v2/',
        timeout: options[:timeout] || 5,
        open_timeout: options[:open_timeout] || 10
      )
    end

    def printery
      @printery ||= Keyline::Printery.new(self, self.perform_request(:get, '/configuration/printery')).tap do |printery|
        printery.extend(Jeweler::SingletonResource)
      end
    end

    def production_products
      Jeweler::Collection.new(
        self,
        -> { self.perform_request(:get, Keyline::Production::Product.path_for_index(nil)) },
        Keyline::Production::Product
      )
    end

    def production_tasks
      Jeweler::Collection.new(
        self,
        -> { self.perform_request(:get, Keyline::Production::Task.path_for_index(nil)) },
        Keyline::Production::Task
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
