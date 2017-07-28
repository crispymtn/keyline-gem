module Keyline
  module Resource
    attr_accessor :attributes, :parent

    module ClassMethods
      cattr_reader :associations

      def from_hash(data, parent = nil)
        associations = self.instance_variable_get(:@associations)
        resource = self.new(data.except(associations), parent)

        data.slice(*associations).each do |association, objects|
          resource.instance_variable_get(:@children)[association] = Collection.new(
            -> { Keyline.client.perform_request(:get, klass.path(self)) },
            "Keyline::#{association.singularize.capitalize}".constantize,
            resource,
            objects)
        end

        return resource
      end

      def attributes(*attributes)
        (%i( id created_at updated_at ).concat(attributes)).each do |attribute|
          define_method attribute do
            @attributes[attribute.to_s]
          end
        end
      end

      def associations(*associations)
        @associations = associations.collect(&:to_s)

        @associations.each do |association|
          define_method association do
            klass = "Keyline::#{association.singularize.capitalize}".constantize
            @children[association.to_s] ||= Collection.new(-> { Keyline.client.perform_request(:get, klass.path(self)) }, klass, self)
          end
        end
      end

      def path_prefix(prefix = nil)
        if prefix
          @prefix = prefix.to_s
        else
          @prefix
        end
      end

      def path(parent = nil)
        self.new({}, parent).path
      end
    end

    def initialize(attributes = {}, parent = nil)
      raise Keyline::Errors::ResourceReadOnlyError.new unless self.class.include?(Writeable::Resource)

      @attributes = attributes.stringify_keys!
      @parent = parent
      @children = {}
      @errors = []
    end

    def path
      Array.new.tap do |segments|
        segments << @parent.path if @parent && !self.class.path_prefix
        segments << self.class.path_prefix if self.class.path_prefix
        segments << self.class.to_s.demodulize.underscore.pluralize
        segments << self.id if self.persisted?
      end.join('/')
    end

    # Provides a possiblity for the given resource
    # to overwrite paths based on HTTP request used
    alias_method :path_for_create, :path
    alias_method :path_for_update, :path
    alias_method :path_for_destroy, :path

    # Only writeable resources cannot be persisted
    def persisted?
      true
    end

    # Only writable resources can be invalid
    def valid?
      true
    end
  end
end
