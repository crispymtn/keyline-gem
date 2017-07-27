module Keyline
  module Writeable
    module Resource
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
        self.attributes = Keyline.client.perform_request(:post, self.path, payload: attributes_for_write)
        return true

      rescue Keyline::Errors::ResourceInvalidError => e
        puts e
        return false
      end

      def update
        self.attributes = Keyline.client.perform_request(:patch, self.path, payload: attributes_for_write)
        return true

      rescue Keyline::Errors::ResourceInvalidError => e
        puts e
        return false
      end

      def destroy
        Keyline.client.perform_request(:delete, self.path)
        attributes['id'] = nil
        return true
      end

      def path
        self.persisted? ? "#{self.class.path}/#{self.id}" : self.class.path
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

    private
      def attributes_for_write
        # Consider all attribute= functoins as writable
        # attributes that need to be send over the wire
        {
          self.class.to_s.demodulize.underscore => @attributes.slice(*self.class.instance_methods.grep(/[a-z]+=/).collect { |a| a.to_s[0..-2].to_sym })
        }
      end
    end
  end
end
