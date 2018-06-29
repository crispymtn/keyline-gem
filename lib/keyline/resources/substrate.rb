module Keyline
  class Substrate
    include Jeweler::SingletonResource
    include Jeweler::Writeable::Resource

    attributes :stock_substrate_id, :imposing_id, :name, :dimensions, :precut_dimensions,
      :grain, :grammage, :color_saturation, :thickness, :kind, :environmental_certification,
      :texture, :color, :automatically_selected

    writeable_attributes :stock_substrate_id, :precut_dimensions
  end
end
