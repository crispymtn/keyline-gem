module Keyline
  class Carrier
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :id, :name, :service, :automated_labels, :bill_individual_parcels, :created_at, :updated_at
    writeable_attributes :name, :service, :automated_labels, :bill_individual_parcels
  end
end
