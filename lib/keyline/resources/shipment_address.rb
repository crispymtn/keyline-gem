module Keyline
  class ShipmentAddress
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    name_in_path :address
    name_in_params :address

    attributes :addressable_id, :addressable_type, :addressee, :street, :number,
      :zip_code, :town, :country_code, :state_or_province, :fingerprint

    writeable_attributes :addressee, :street, :number, :zip_code, :town, :country_code, :state_or_province
  end
end
