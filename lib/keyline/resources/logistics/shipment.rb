module Keyline
  module Logistics
    class Shipment
      include Jeweler::Resource
      include Jeweler::Writeable::Resource

      path_prefix :logistics

      attributes :reference, :carrier_id, :state, :delivery_contact_phone, :delivery_contact_email, :pick_up_at
      writeable_attributes :state

      def carrier
        self.attributes['carrier'].symbolize_keys
      end

      def address
        self.attributes['address'].symbolize_keys
      end

      def parcels
        self.attributes['parcels'].collect(&:symbolize_keys)
      end
    end
  end
end
