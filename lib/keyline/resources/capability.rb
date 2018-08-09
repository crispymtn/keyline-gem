module Keyline
  class Capability
    include Jeweler::Resource

    attributes :kind, :inline, :means_of_production_id
   end
end
