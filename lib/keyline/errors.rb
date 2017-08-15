module Keyline
  class Error < Exception
    attr_reader :raw_payload

    def initialize(payload)
      @raw_payload = payload
    end
  end

  module Errors
    class ResourceInvalidError < Error
      attr_reader :validation_errors

      def initialize(payload)
        super(payload)
        @validation_errors = payload['errors']
      end
    end

    class UnknownAttributeError < Error
    end

    class BadRequestError < Error
      attr_reader :missing_parameters

      def initialize(payload)
        super(payload)
        @missing_parameters = payload['missing_parameters'] if payload.has_key?('missing_parameters')
      end
    end

    class RemoteServerError < Error
    end

    class ResourceNotFoundError < Error
    end

    class ParentNotPersistedError < Error
    end

    class ResourceReadOnlyError < Error
    end
  end
end
