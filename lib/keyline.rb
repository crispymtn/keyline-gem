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

    def orders
      @orders ||= Collection.new(-> { client.perform_request(:get, Keyline::Order.path) }, Keyline::Order)
    end

    def products
      @products ||= Collection.new(-> { client.perform_request(:get, Keyline::Product.path) }, Keyline::Product)
    end

    def stock_papers
      @stock_papers ||= Collection.new(-> { client.perform_request(:get, Keyline::StockPaper.path) }, Keyline::StockPaper)
    end
  end
end
