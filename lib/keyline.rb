require 'active_support/all'
require 'keyline/version'
require 'keyline/client'

module Keyline
  class << self
    def client(options = {})
      @client ||= Keyline::Client.new(options)
    end

    def orders
      @orders ||= Collection.new(-> { client.perform_request(:get, Keyline::Order.path) }, Keyline::Order)
    end

    def products
      @products ||= Collection.new(-> { client.perform_request(:get, Keyline::Product.path) }, Keyline::Product)
    end
  end
end
