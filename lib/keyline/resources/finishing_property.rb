module Keyline
  class FinishingProperty
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :key, :value, :unit, :show_to_customer
    writeable_attributes :value, :show_to_customer
  end
end
