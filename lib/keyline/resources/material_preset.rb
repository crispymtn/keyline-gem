module Keyline
  class MaterialPreset
    include Resource
    include Writeable::Resource

    attributes :material_id, :raw_material_requirement_name
    writeable_attributes :material_id, :raw_material_requirement_name
  end
end
