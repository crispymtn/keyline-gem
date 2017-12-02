module Keyline
  class Variant
    include Resource
    include Writeable::Resource

    attributes :name
    writeable_attributes :name
  end
end
