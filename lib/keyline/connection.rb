require 'faraday'

module Keyline
  module Connection
    attr_reader :token, :host, :base_uri

    def initialize(options = {})
      @host     = options[:host] || 'https://api.keyline-mis.com'
      @base_uri = '/api/v2/'
      @token    = options[:token] || ENV['KEYLINE_API_TOKEN'] || (defined?(Rails) ? Rails.application.secrets&.keyline_api_token : nil)
    end

    def perform_request(method, url, options = {})
      connection = Faraday.new
      response = connection.send(method) do |request|
        set_headers(request)
        request.url "#{@host}#{@base_uri}#{url}"
        request.body = options[:payload].to_json if options.has_key?(:payload)
      end

      if response.success?
        if response.body.length > 0
          JSON.parse(response.body)
        else
          true
        end
      else
        case response.status
        when 400 then raise Keyline::Errors::BadRequestError.new
        when 404 then raise Keyline::Errors::ResourceNotFoundError.new
        when 422 then raise Keyline::Errors::ResourceInvalidError.new(JSON.parse(response.body))
        when 500 then raise Keyline::Errors::RemoteServerError.new
        end
      end
    end

private
    def set_params(request, params)
      params.each do |param, value|
        request.params[param.to_s] = value
      end
    end

    def set_headers(request)
      request.headers['Content-Type']  = 'application/json'
      request.headers['Authorization'] = "Bearer #{@token}"
    end
  end
end
