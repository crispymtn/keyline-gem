module Keyline
  module Errors
    class ResourceInvalidError < Exception
      attr_accessor :validation_errors

      def initialize(payload)
        @validation_errors = payload
      end
    end

    class RemoteServerError < Exception
    end

    class ResourceNotFoundError < Exception
    end

    class ParentNotPersistedError < Exception
    end 
  end
end
