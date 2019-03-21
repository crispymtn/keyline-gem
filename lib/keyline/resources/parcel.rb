module Keyline
  class Parcel
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    path_prefix :logistics

    attributes :shipment_id, :state, :dimensions, :weight, :label_url, :tracking_url, :tracking_code, :created_at, :updated_at
    writeable_attributes :state, :tracking_code, :tracking_url, :label_url

    singleton_associations :shipment, :carrier
    associations :document_callbacks

    def self.find_by_tracking_code(client:, tracking_code:)
      self.new(client,
        client.perform_request(:get, self.path + "/find?tracking_code=#{tracking_code}")
      )
    end

    def to_address
      self.attributes['shipment']['address'].symbolize_keys
    end

    def from_address
      self.attributes['from_address'].symbolize_keys
    end
  end
end
