module Keyline
  class MaterialQuote
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :material_id, :supplier_id, :supplier_name, :amount, :minimum_order_quantity,
      :unit, :order_number, :usual_delivery_time_in_business_days
    writeable_attributes :supplier_id, :amount, :unit, :minimum_order_quantity, :order_number, :usual_delivery_time_in_business_days

    def name_in_path
      'quotes'
    end
  end
end
