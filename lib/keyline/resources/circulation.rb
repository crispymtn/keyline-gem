module Keyline
  class Circulation
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :amount, :variant_id
    writeable_attributes :amount
  end
end
