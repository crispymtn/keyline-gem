module Keyline
  class Order
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    path_prefix :sales
    attributes :reference, :confirmed_at, :state
    writeable_attributes :confirmed_at, :state
    associations :products
  end
end
