module Keyline
  class AddressAnnouncement
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :customer_id, :customer_type, :addressee, :street, :number,
      :zip_code, :town, :country_code, :fingerprint

    writeable_attributes :addressee, :street, :number, :zip_code, :town, :country_code
  end
end
