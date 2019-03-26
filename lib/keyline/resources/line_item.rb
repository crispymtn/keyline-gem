module Keyline
  class LineItem
    include Jeweler::Resource

    attributes :description, :qty, :unit, :net_total, :gross_total, :net,
    :discount, :discounted_net_total, :order_number, :environmental_certifications

    singleton_associations :accounting_category
  end
end
