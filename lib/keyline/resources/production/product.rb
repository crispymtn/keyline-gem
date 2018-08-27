module Keyline::Production
  class Product
    include Jeweler::Resource

    path_prefix :production
    attributes :stock_product_id, :reference, :name, :kind, :custom_references

    associations :components, :finishings, :order, :selected_production_path, :print_data_files
  end
end
