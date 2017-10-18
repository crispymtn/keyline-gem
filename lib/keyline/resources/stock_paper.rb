module Keyline
  class StockPaper
    include Resource
    extend  Resource::ClassMethods

    path_prefix :conception

    attributes :name, :dimensions, :grain, :grammage, :color_saturation, :color,
      :thickness, :kind, :environmental_certification, :texture, :delivered_precut, :supplier_identifiers

    associations :material_quotes
  end
end
