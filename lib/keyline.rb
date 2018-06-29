require 'active_support/all'
require 'keyline/version'
require 'keyline/client'

module Keyline
  class << self

    delegate :connection_valid?, to: :client

    def client(options = {})
      if options.any?
        @client = Keyline::Client.new(options)
      else
        @client ||= Keyline::Client.new(options)
      end
    end

    def client=(client)
      @client = client
    end

    def with_connection(token: nil, host: nil)
      if token || host
        token ||= Keyline.client.connection.token
        host ||= Keyline.client.connection.host
        new_client = Keyline::Client.new(token: token, host: host)
        raise ArgumentError.new "Can't connect to Keyline API at #{new_client.host} with given connection details!" unless new_client.connection_valid?

        previous_client = Keyline.client
        Keyline.client = new_client
      end
      yield
    ensure
      Keyline.client = previous_client if previous_client
    end

    def printery
      @printery ||= Keyline::Printery.new(client.perform_request(:get, Keyline::Printery.path))
    end

    def organizations
      @organizations ||= Collection.new(-> { client.perform_request(:get, Keyline::Organization.path) }, Keyline::Organization)
    end

    def people
      @people ||= Collection.new(-> { client.perform_request(:get, Keyline::Person.path) }, Keyline::Person)
    end

    def suppliers
      @suppliers ||= Collection.new(-> { client.perform_request(:get, Keyline::Supplier.path) }, Keyline::Supplier)
    end

    def materials
      @materials ||= Collection.new(-> { client.perform_request(:get, Keyline::Material.path) }, Keyline::Material)
    end

    def material_storage_areas
      @material_storage_areas ||= Collection.new(-> { client.perform_request(:get, Keyline::MaterialStorageArea.path) }, Keyline::MaterialStorageArea)
    end

    def orders
      @orders ||= Collection.new(-> { client.perform_request(:get, Keyline::Order.path) }, Keyline::Order)
    end

    def products
      @products ||= Collection.new(-> { client.perform_request(:get, Keyline::Product.path) }, Keyline::Product)
    end

    def stock_substrates
      @stock_substrates ||= Collection.new(-> { client.perform_request(:get, Keyline::StockSubstrate.path) }, Keyline::StockSubstrate)
    end

    def stock_finishings
      @stock_finishings ||= Collection.new(-> { client.perform_request(:get, Keyline::StockFinishing.path) }, Keyline::StockFinishing)
    end

    def stock_products
      @stock_products ||= Collection.new(-> { client.perform_request(:get, Keyline::StockProduct.path) }, Keyline::StockProduct)
    end

    def parcels
      @parcels ||= Collection.new(-> { client.perform_request(:get, Keyline::Parcel.path) }, Keyline::Parcel)
    end
  end
end
