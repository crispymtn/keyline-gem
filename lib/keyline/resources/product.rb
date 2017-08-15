module Keyline
  class Product
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    path_prefix :conception
    attributes :reference, :name, :kind
    writeable_attributes :name, :kind
    associations :components, :finishings, :production_paths, :packagings, :print_data_files

    def path_for_create
      "sales/orders/#{self.parent&.id}/products"
    end

    def path_for_index
      "sales/orders/#{self.parent&.id}/products"
    end
  end
end
