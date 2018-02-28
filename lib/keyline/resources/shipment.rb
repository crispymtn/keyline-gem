module Keyline
  class Shipment
    include SingletonResource
    include Writeable::Resource

    attributes :carrier_id, :delivery_contact_phone, :delivery_contact_email, :pick_up_at
    writeable_attributes :carrier_id, :delivery_contact_phone, :delivery_contact_email, :pick_up_at

    associations :shipment_address
  end
end
