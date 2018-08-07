module Keyline
  class StockTask
    include Jeweler::Resource

    path_prefix :configuration
    attributes :kind, :required_means_of_production_capability, :description, :phase, :checkpoint,
      :raw_material_requirements, :processing_requirements, :formula_for_amount_of_manufactured_products,
      :amount_of_packagings, :formula_for_amount_of_wasted_manufactured_products,
      :manufactured_product, :product_processing, :required_completion_for_starting_dependencies
  end
end
