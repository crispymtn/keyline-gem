module Keyline
  class Error < Exception
  end

  module Errors
    class ResourceInvalidError < Error
      attr_accessor :validation_errors

      def initialize(payload)
        @validation_errors = payload['errors']
      end
    end

    class UnknownAttributeError < Error
    end

    class BadRequestError < Error
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
