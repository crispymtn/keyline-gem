module Keyline
  class Product
    include Resource
    include Writeable::Resource
  
    path_prefix :conception
    attributes :stock_product_id, :reference, :name, :kind
    writeable_attributes :stock_product_id, :name, :kind
    associations :components, :finishings, :production_paths, :packagings, :print_data_files, :variants, :stock_finishings

    def path_for_create
      "sales/orders/#{self.parent&.id}/products"
    end

    def path_for_index
      "sales/orders/#{self.parent&.id}/products"
    end
  end
end
