module Keyline
  class StockColor
    include Jeweler::Resource

    path_prefix :configuration

    attributes :name, :system, :hex_code
  end
end
