module Keyline::Production
  class Packaging
    include Jeweler::Resource

    attributes :order_id, :product_id, :target_storage_area_id,
      :shipment_id, :reference, :custom_references, :state, :description, :kind, :gurantee,
      :amount, :remainder, :completed_amount, :deposition, :labeled

    associations :picks
    singleton_associations :shipment
  end
end
