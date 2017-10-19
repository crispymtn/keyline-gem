module Keyline
  class StockProduct
    include Resource
    extend  Resource::ClassMethods

    path_prefix :configuration
    attributes :name, :category, :order_number, :description, :automated_billing
  end
end
