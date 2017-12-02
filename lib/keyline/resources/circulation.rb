module Keyline
  class Circulation
    include Resource
    include Writeable::Resource

    attributes :amount, :variant_id
    writeable_attributes :amount
  end
end
