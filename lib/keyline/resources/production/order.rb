module Keyline::Production
  class Order
    include Jeweler::Resource

    attributes :reference, :custom_references, :custom_ofer_text, :due_at, :confirmed_at, :state

    singleton_associations :customer
  end
end
