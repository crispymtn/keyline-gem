module Keyline
  class StockFoldingPattern
    include Jeweler::Resource

    path_prefix :configuration

    attributes :name, :steps, :included_in_jdf, :columns, :rows,
      :pagination, :orientation, :category, :infeed_orientation
  end
end
