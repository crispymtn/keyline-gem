module Keyline
  class Pick
    include Resource
    include Writeable::Resource

    attributes :pickable_id, :pickable_type, :packaging_id, :source_storage_area_id, :amount_per_packaging, :amount
    writeable_attributes :amount_per_packaging, :pickable_type, :pickable_id, :amount
  end
end
