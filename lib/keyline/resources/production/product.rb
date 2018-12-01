module Keyline::Production
  class Product
    include Jeweler::Resource

    path_prefix :production
    attributes :stock_product_id, :reference, :name, :kind, :custom_references

    associations :components, :finishings, :print_data_files
    singleton_associations :order, :selected_production_path
  end
end
