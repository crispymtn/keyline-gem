module Keyline
  class Variant
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :name
    writeable_attributes :name
  end
end
