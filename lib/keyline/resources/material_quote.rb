module Keyline
  class MaterialQuote
    include Resource
    extend  Resource::ClassMethods

    attributes :material_id, :supplier_id, :supplier_name, :amount, :minimum_order_quantity,
      :unit, :order_number, :usual_delivery_time_in_business_days
  end
end
