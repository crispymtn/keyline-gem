require 'active_support/all'
require 'keyline/version'
require 'keyline/client'

module Keyline
  class << self
    def client(options = {})
      if options.any?
        @client = Keyline::Client.new(options)
      else
        @client ||= Keyline::Client.new(options)
      end
    end

    def connection_valid?
      client.perform_request(:get, 'configuration/printery') ? true : false
    end

    def printery
      @printery ||= Keyline::Printery.new(client.perform_request(:get, Keyline::Printery.path))
    end

    def suppliers
      @suppliers ||= Collection.new(-> { client.perform_request(:get, Keyline::Supplier.path) }, Keyline::Supplier)
    end

    def materials
      @materials ||= Collection.new(-> { client.perform_request(:get, Keyline::Material.path) }, Keyline::Material)
    end

    def orders
      @orders ||= Collection.new(-> { client.perform_request(:get, Keyline::Order.path) }, Keyline::Order)
    end

    def products
      @products ||= Collection.new(-> { client.perform_request(:get, Keyline::Product.path) }, Keyline::Product)
    end

    def stock_papers
      @stock_papers ||= Collection.new(-> { client.perform_request(:get, Keyline::StockPaper.path) }, Keyline::StockPaper)
    end

    def stock_finishings
      @stock_finishings ||= Collection.new(-> { client.perform_request(:get, Keyline::StockFinishing.path) }, Keyline::StockFinishing)
    end

    def stock_products
      @stock_products ||= Collection.new(-> { client.perform_request(:get, Keyline::StockProduct.path) }, Keyline::StockProduct)
    end
  end
end
