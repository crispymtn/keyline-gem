module Keyline
  module Writeable
    module Collection
      def create(attributes = {})
        self.build(attributes).tap do |object|
          object.save
        end
      end

      def build(attributes = {})
        @resource_klass.new(attributes, @owner)
      end
    end

    module Resource
      attr_accessor :errors

      module ClassMethods
        def writeable_attributes(*attributes)
          attributes.each do |attribute|
            define_method "#{attribute}=" do |value|
              @attributes[attribute.to_s] = value
            end
          end
        end
      end

      def save
        raise Keyline::Errors::ParentNotPersistedError, 'you can\'t save a child object unless its parent has been saved' if self.parent && !self.parent.persisted?
        self.persisted? ? self.update : self.create
      end

      def create
        self.attributes = Keyline.client.perform_request(:post, self.path_for_create, payload: attributes_for_write)
        return true

      rescue Keyline::Errors::ResourceInvalidError => e
        @errors = e.validation_errors
        return false
      end

      def update
        self.attributes = Keyline.client.perform_request(:patch, self.path_for_update, payload: attributes_for_write)
        return true

      rescue Keyline::Errors::ResourceInvalidError => e
        @errors = e.validation_errors
        return false
      end

      def destroy
        Keyline.client.perform_request(:delete, self.path_for_destroy)
        attributes['id'] = nil
        return true
      end

      def attributes=(attributes)
        @attributes = attributes
      end

      def persisted?
        self.id.present?
      end

      def valid?
        @errors.empty?
      end

      def writeable_attributes
        @attributes.slice(*self.class.instance_methods.grep(/[a-z]+=/).collect { |a| a.to_s[0..-2] })
      end

    private
      def build_errors(response)
        @errors = JSON.parse(response)
      end

      def attributes_for_write
        # Consider all attribute= functoins as writable
        # attributes that need to be send over the wire
        {
          self.class.to_s.demodulize.underscore => self.writeable_attributes
        }
      end
    end
  end
end
