module Keyline
  class Collection
    include Enumerable

    def initialize(retrieval_proc, resource_klass, prefetched_objects = nil)
      @retrieval_proc     = retrieval_proc
      @resource_klass     = resource_klass
      @prefetched_objects = prefetched_objects
      @retrieved          = false
    end

    def objects
      return @objects if @retrieved

      data = @prefetched_objects ? @prefetched_objects : @retrieval_proc.call
      @objects = data.collect { |o| @resource_klass.from_hash(o) }
      @retrieved = true

      return @objects
    end

    def reload
      @prefetched_objects = nil
      @retrieved = false
    end

    def each(&block)
      objects.each { |item| yield item }
    end
  end
end
