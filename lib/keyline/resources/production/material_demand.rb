module Keyline::Production
  class MaterialDemand
    include Jeweler::Resource

    attributes :material_id, :name, :unit, :qty, :actual_qty
  end
end
