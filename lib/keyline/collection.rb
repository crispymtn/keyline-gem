module Keyline
  class Collection
    include Enumerable
    include Writeable::Collection

    def initialize(retrieval_proc, resource_klass, owner = nil, prefetched_objects = nil)
      @retrieval_proc     = retrieval_proc
      @resource_klass     = resource_klass
      @owner              = owner
      @prefetched_objects = prefetched_objects
      @retrieved          = false
    end

    def find(id)
      @resource_klass.from_hash(Keyline.client.perform_request(:get, "#{@resource_klass.path}/#{id}"), @owner)
    end

    def objects
      return @objects if @retrieved

      data = @prefetched_objects ? @prefetched_objects : @retrieval_proc.call
      @objects = data.collect { |o| @resource_klass.from_hash(o, @owner) }
      @retrieved = true

      return @objects
    end

    def [](index)
      objects[index]
    end

    def reload!
      @prefetched_objects = nil
      @retrieved = false
      @objects = objects
      self
    end

    def each(&block)
      objects.each { |item| yield item }
    end
  end
end
