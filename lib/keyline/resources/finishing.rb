module Keyline
  class Finishing
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :stock_finishing_id, :kind
    writeable_attributes :stock_finishing_id
    associations :finishing_properties, :material_presets, :print_data_files
  end
end
