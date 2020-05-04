module Keyline
  class MaterialDemand
    include Jeweler::Resource

    attributes :material_id, :name, :unit, :qty, :actual_qty
    singleton_associations :material
  end
end
