module Keyline
  class Event
    attr_reader :payload, :name, :object_class, :object_id, :action, :path, :version

    def initialize(raw_data:, checksum:, secret:)
      verify_checksum!(raw_data: raw_data, checksum: checksum, secret: secret)
      data = JSON.parse(raw_data).with_indifferent_access[:event]

      @name           = data[:name]
      @object_id      = data[:object_id]
      @object_class   = data[:object_class]
      @action         = data[:action]
      @path           = data[:path]
      @payload        = data[:data]
      @version        = data[:version]
    end

    def [](key)
      @payload[:attributes][key.to_s]
    end

    def changed_attributes
      @payload[:changes].keys
    end

    def changes
      @payload[:changes]
    end

    def attribute_changed?(key)
      @payload[:changes].has_key?(key.to_s)
    end

    def previous_value_for(key)
      @payload[:changes][key.to_s]&.first
    end

    def new_value_for(key)
      @payload[:changes][key.to_s]&.last
    end

  private
    def verify_checksum!(raw_data:, checksum:, secret:)
      expected_checksum = "sha1=" + OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest.new('sha1'), secret, raw_data)

      unless ActiveSupport::SecurityUtils.secure_compare(expected_checksum, checksum)
        raise Keyline::Errors::EventChecksumMismatch, "provided checksum #{expected_checksum} does not match calculated checksum #{checksum}"
      end
    end
  end
end
