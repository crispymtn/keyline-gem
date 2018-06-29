module Keyline
  class Variant
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :name
    writeable_attributes :name
  end
end
