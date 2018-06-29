module Keyline
  class Packaging
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :order_id, :product_id, :target_storage_area_id,
      :shipment_id, :reference, :custom_references, :state, :description, :kind, :gurantee,
      :amount, :remainder, :completed_amount, :deposition, :labeled

    writeable_attributes :description, :kind, :gurantee, :deposition, :labeled, :shipment_id

    #associations :picks, :shipment
  end
end
