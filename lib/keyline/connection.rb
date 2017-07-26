module Keyline
  module Connection
    attr_reader :token, :host, :base_uri

    def initialize(options = {})
      @host     = options[:host] || 'https://api.keyline-mis.com'
      @base_uri = '/api/v1/'
      @token    = options[:token] || ENV['KEYLINE_API_TOKEN'] || (defined?(Rails) ? Rails.application.secrets&.keyline_api_token : nil)
    end

  private
    def perform_request(method, url, options)
      Faraday.new(url: url) do |connection|
        connection.send(method) do |request|
          set_headers(request)
        end
      end
    end

    def set_params(request, params)
      params.each do |param, value|
        request.params[param.to_s] = value
      end
    end

    def set_headers(request)
      request.headers['Content-Type']   = 'application/json'
      request.headers['Authentication'] = "Bearer #{@token}"
    end
  end
end
