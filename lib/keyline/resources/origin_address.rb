module Keyline
  class OriginAddress
    include Jeweler::Resource

    attributes :addressable_id, :addressable_type, :addressee, :street, :number,
      :zip_code, :town, :country_code, :state_or_province, :fingerprint      
  end
end
