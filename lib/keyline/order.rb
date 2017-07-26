module Keyline
  class Order
    include Resource
    extend  Resource::ClassMethods
    attributes :reference, :confirmed_at, :state



  end
end
