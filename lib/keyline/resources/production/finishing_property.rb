module Keyline::Production
  class FinishingProperty
    include Jeweler::Resource

    attributes :key, :value, :unit, :show_to_customer
  end
end
