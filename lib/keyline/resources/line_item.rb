module Keyline
  class LineItem
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :description, :qty, :unit, :net_total, :tax_rate, :gross_total,
      :net, :discount, :discounted_net_total, :order_number,
      :environmental_certifications

    writeable_attributes :order_number, :description, :qty, :unit, :net, :tax_rate,
      :discount, :accounting_category_ids

    associations :accounting_categories
  end
end
