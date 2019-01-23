module Keyline
  class Carrier
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :name, :service, :automated_labels, :bill_individual_parcels,
      :supported_countries

    writeable_attributes :name, :service, :automated_labels,
      :bill_individual_parcels, :supported_countries
  end
end
