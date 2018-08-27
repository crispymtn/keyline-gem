module Keyline::Production
  class Order
    include Jeweler::SingletonResource

    attributes :reference, :custom_references, :custom_ofer_text, :due_at, :confirmed_at, :state

    associations :customer
  end
end
