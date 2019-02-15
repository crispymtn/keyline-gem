module Keyline
  class MaterialPreset
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :material_id
    writeable_attributes :material_id

    singleton_associations :material
  end
end
