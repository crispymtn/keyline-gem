module Keyline
  class StockProduct
    include Jeweler::Resource

    path_prefix :configuration
    attributes :name, :category, :order_number, :description, :automated_billing
  end
end
