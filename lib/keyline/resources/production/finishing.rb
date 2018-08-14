module Keyline::Production
  class Finishing
    include Jeweler::Resource

    attributes :stock_finishing_id, :kind
    associations :finishing_properties, :material_presets
  end
end
