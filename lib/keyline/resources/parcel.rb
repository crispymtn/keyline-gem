module Keyline
  class Parcel
    include Resource
    include Writeable::Resource

    path_prefix :logistics

    attributes :shipment_id, :state, :dimensions, :weight, :label_url, :tracking_url,
      :tracking_code, :created_at, :updated_at

    writeable_attributes :state, :tracking_code, :tracking_url, :label_url

    # convenience access to nested attributes
    def shipment
      Keyline::Shipment.from_hash(self.attributes['shipment'])
    end

    def shipment_address
      Keyline::Shipment.from_hash(self.attributes['shipment']['address'])
    end
  end
end
