module Keyline
  class Capability
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :kind, :inline, :means_of_production_id
    writeable_attributes :kind, :inline, :means_of_production_id
   end
end
