module Keyline
  class Circulation
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :amount, :variant_id
    writeable_attributes :amount
  end
end
