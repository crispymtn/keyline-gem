module Keyline
  class ShipmentAddress
    include Jeweler::SingletonResource
    include Jeweler::Writeable::Resource

    attributes :addressable_id, :addressable_type, :addressee, :street, :number,
      :zip_code, :town, :country_code, :state_or_province, :fingerprint

    writeable_attributes :addressee, :street, :number, :zip_code, :town, :country_code, :state_or_province

    def name_in_path
      'address'
    end

    def name_in_params
      'address'
    end
  end
end
