module Keyline::Production
  class Customer
    include Jeweler::SingletonResource

    attributes :name, :reference
  end
end
