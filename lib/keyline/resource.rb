module Keyline
  module Resource
    attr_reader :attributes

    module ClassMethods
      def from_hash(data)
        self.new(data)
      end

      def attributes(*attributes)
        (%i( id created_at updated_at).concat(attributes)).each do |attribute|
          define_method attribute do
            @attributes[attribute]
          end

          define_method "#{attribute}=" do |value|
            @attributes[attribute] = value
          end
        end
      end
    end

    def initialize(attributes = {})
      @attributes = attributes
    end
  end
end
