module Keyline
  class Product
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    path_prefix :conception
    attributes :stock_product_id, :reference, :name, :kind, :custom_references,
      :custom_description

    writeable_attributes :stock_product_id, :name, :kind, :custom_references,
      :custom_description

    associations :components, :finishings, :production_paths, :packagings, :print_data_files,
      :variants, :stock_finishings, :material_presets, :services

    def path_for_create
      "sales/orders/#{self.parent&.id}/products"
    end

    def path_for_index
      path_for_create
    end

    def selected_production_path
      self.production_paths.select { |pp| pp.selected_for_production }.first
    end
  end
end
