module Keyline
  class Collection
    include Enumerable
    include Finders
    include Writeable::Collection

    def initialize(retrieval_proc, resource_klass, owner = nil, prefetched_objects = nil)
      @retrieval_proc     = retrieval_proc
      @resource_klass     = resource_klass
      @owner              = owner
      @prefetched_objects = prefetched_objects
      @retrieved          = false
    end

    def find(id)
      @resource_klass.from_hash(
        Keyline.client.perform_request(:get, "#{@resource_klass.path_for_show(@owner)}/#{id}"),
        @owner)
    end

    def objects
      return @objects if @retrieved

      data = if @owner && !@owner.persisted?
        @objects = []

      elsif @prefetched_objects
        @objects = @prefetched_objects

      else
        @retrieval_proc.call
      end

      @retrieved = true
      @objects = data.collect { |o| @resource_klass.from_hash(o, @owner) }

      return @objects
    end

    def [](index)
      objects[index]
    end

    def size
      length
    end

    def length
      objects.length
    end

    def reload!
      # Don't try to reload collections from owners
      # that are not persisted yet
      return self unless @owner && @owner.persisted?

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
