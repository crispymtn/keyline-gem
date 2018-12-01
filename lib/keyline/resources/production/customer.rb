module Keyline::Production
  class Customer
    include Jeweler::Resource

    attributes :name, :reference
  end
end
