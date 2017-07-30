module Keyline
  class Packaging
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :order_id, :product_id, :target_storage_area_id,
      :shipment_id, :reference, :custom_references, :state, :description, :kind, :gurantee,
      :amount, :remainder, :completed_amount, :deposition, :labeled

    writeable_attributes :description, :kind, :gurantee, :deposition, :labeled

    associations :picks
  end
end
