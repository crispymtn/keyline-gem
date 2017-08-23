module Keyline
  module Writeable
    module Collection
      def create(attributes = {})
        self.build(attributes).tap do |object|
          object.save
        end
      end

      def build(attributes = {})
        @resource_klass.new(attributes, @owner).tap do |new_object|
          self.objects << new_object
        end
      end
    end

    module Resource
      attr_reader :errors

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
        perform_request do
          self.attributes = Keyline.client.perform_request(:post, self.path_for_create, payload: attributes_for_write)
        end
      end

      def update
        perform_request do
          # PATCH requests usually return 204 No Content, so don't assign the response to attributes
          Keyline.client.perform_request(:patch, self.path_for_update, payload: attributes_for_write)
        end
      end

      def destroy
        perform_request do
          Keyline.client.perform_request(:delete, self.path_for_destroy)
          attributes['id'] = nil
        end
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
      def perform_request(&block)
        block.call
        clear_errors
        return true

      rescue Keyline::Errors::BadRequestError => e
        @errors = e.missing_parameters.nil? ? e.raw_payload : e.missing_parameters
        return false
      rescue Keyline::Errors::ResourceInvalidError => e
        @errors = e.validation_errors
        return false
      end

      def clear_errors
        @errors = []
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
