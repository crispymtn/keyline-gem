module Keyline::Production
  class Product
    include Jeweler::Resource

    path_prefix :production, overwrite_parent_path: false

    attributes :stock_product_id, :reference, :name, :kind, :custom_references,
      :production_started_at, :production_completed_at, :cleared_at

    associations :components, :finishings, :print_data_files, :variants
    singleton_associations :order, :selected_production_path
  end
end
