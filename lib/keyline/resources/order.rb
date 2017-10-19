module Keyline
  class Order
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    path_prefix :sales
    attributes :reference, :confirmed_at, :state, :due_at, :custom_references, :custom_offer_text, :customer_id
    writeable_attributes :confirmed_at, :state, :due_at, :custom_references, :custom_offer_text, :customer_id
    associations :products
  end
end
