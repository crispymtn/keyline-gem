module Keyline::Production
  class MaterialDemand
    include Jeweler::Resource

    attributes :material_id, :name, :unit, :expected_qty, :actual_qty
  end
end
