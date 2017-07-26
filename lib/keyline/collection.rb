module Keyline
  class Collection
    include Enumerable

    def initialize(objects, resource_klass)
      @resource_klass = resource_klass
    end

    def each(&block)
      collection.each { |item| yield item }
    end

  private
    def collection
      @collection ||= objects.collect { |o| @resource_klass.from_json(o) }
    end
  end
end
