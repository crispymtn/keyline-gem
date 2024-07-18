module Keyline::Production
  class Variant
    include Jeweler::Resource

    attributes :name, :amount
  end
end
