module Keyline
  class StockPaper
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    path_prefix :configuration

    attributes :name, :dimensions, :grain, :grammage, :color_saturation, :color, :material_id,
      :thickness, :kind, :environmental_certification, :texture, :delivered_precut, :supplier_identifiers
    writeable_attributes :name, :dimensions, :grain, :grammage, :color_saturation, :color,
      :thickness, :kind, :environmental_certification, :texture, :delivered_precut, :supplier_identifiers
  end
end
