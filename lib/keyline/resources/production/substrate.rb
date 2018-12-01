module Keyline::Production
  class Substrate
    include Jeweler::Resource

    attributes :stock_substrate_id, :imposing_id, :name, :dimensions, :precut_dimensions,
      :grain, :grammage, :color_saturation, :thickness, :kind, :environmental_certification,
      :texture, :color, :automatically_selected
  end
end
