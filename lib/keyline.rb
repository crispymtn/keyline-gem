require 'active_support/all'
require 'keyline/version'
require 'keyline/client'

module Keyline
  class << self
    def client(options = { host: 'http://keyline.dev', token: '8cad2674e47403b75a84890985f027e2ac6e897a69109074a37919bf4e2b48cc' })
      return @client if defined?(@client)
      @client = Keyline::Client.new(options)
    end

    def orders
      @orders ||= Collection.new(-> { client.perform_request(:get, Keyline::Order.path) }, Keyline::Order)
    end

    def products
      @products ||= Collection.new(-> { client.perform_request(:get, Keyline::Product.path) }, Keyline::Product)
    end
  end
end
