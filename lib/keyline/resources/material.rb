module Keyline
  class Material
    include Jeweler::Resource

    path_prefix :warehouse

    attributes :name, :description, :kind, :unit, :material_storage_area_id, :billing_mode, :height,
      :width, :depth, :weight, :product_related_ordering, :warehouse_code, :applied_processings

    associations :material_quotes
  end
end
