module Keyline
  class StockSubstrate
    include Resource
    include Writeable::Resource

    path_prefix :configuration

    attributes :name, :kind, :category, :dimensions, :grain, :grammage, :color_saturation, :color, :material_id,
      :thickness, :kind, :environmental_certification, :texture, :delivered_precut, :supplier_identifiers

    writeable_attributes :name, :kind, :category, :dimensions, :grain, :grammage, :color_saturation, :color,
      :thickness, :kind, :environmental_certification, :texture, :delivered_precut, :supplier_identifiers
  end
end
