module Keyline
  module Resource
    attr_accessor :attributes

    module ClassMethods
      cattr_reader :associations

      def from_hash(data, parent = nil)
        associations = self.instance_variable_get(:@associations)
        object = self.new(data.except(associations), parent)

        data.slice(*associations).each do |association, objects|
          object.instance_variable_get(:@children)[association] = Collection.new(
            -> { objects },
            "Keyline::#{association.singularize.capitalize}".constantize,
            objects)
        end

        return object
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

        associations.each do |association|
          define_method association do
            @children[association.to_s] ||= Collection.new(-> { objects },
              "Keyline::#{association.singularize.capitalize}".constantize)
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

      def path
        "#{self.path_prefix}/#{self.to_s.demodulize.underscore.pluralize}"
      end
    end

    def initialize(attributes = {}, parent = nil)
      @attributes = attributes
      @parent = parent
      @children = {}
      @errors = []
    end

    def parent
      @parent
    end

    def path
      "#{self.class.path}/#{self.id}"
    end

    def valid?
      true # Only writable resources can be invalid
    end
  end
end
