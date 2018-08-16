module Keyline::Production
  class Product
    include Jeweler::Resource

    path_prefix :production
    attributes :stock_product_id, :reference, :name, :kind, :custom_references

    associations :components, :finishings, :production_path, :packagings, :print_data_files,
      :variants, :stock_finishings, :material_presets
  end
end
