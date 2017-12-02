module Keyline
  class FinishingProperty
    include Resource
    include Writeable::Resource
  
    attributes :key, :value, :unit, :show_to_customer
    writeable_attributes :value, :show_to_customer
  end
end
