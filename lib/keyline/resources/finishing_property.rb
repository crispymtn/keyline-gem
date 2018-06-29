module Keyline
  class FinishingProperty
    include Jeweler::Resource
    include Jeweler::Writeable::Resource
  
    attributes :key, :value, :unit, :show_to_customer
    writeable_attributes :value, :show_to_customer
  end
end
