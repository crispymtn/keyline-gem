module Keyline
  class Shipment
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :reference, :carrier_id, :delivery_contact_phone, :incoterm,
      :delivery_contact_email, :pick_up_at, :delivery_instructions

    writeable_attributes :carrier_id, :delivery_contact_phone, :incoterm,
      :delivery_contact_email, :pick_up_at, :delivery_instructions

    singleton_associations :address, :origin_address, :carrier
    associations :document_callbacks, :parcels
  end
end
