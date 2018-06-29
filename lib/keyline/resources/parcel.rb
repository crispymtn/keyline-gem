module Keyline
  class Parcel
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    path_prefix :logistics

    attributes :shipment_id, :state, :dimensions, :weight, :label_url, :tracking_url, :tracking_code, :created_at, :updated_at
    writeable_attributes :state, :tracking_code, :tracking_url, :label_url

    ## convenience access to nested attributes
    def shipment
      self.attributes['shipment'].symbolize_keys.except(:address, :carrier)
    end

    def carrier
      self.attributes['shipment']['carrier'].symbolize_keys
    end

    def address
      self.attributes['shipment']['address'].symbolize_keys
    end
  end
end
