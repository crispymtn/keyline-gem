module Keyline
  class StockFinishing
    include Resource
    extend  Resource::ClassMethods

    attributes :kind, :common, :permitted_finishable_type, :properties
  end
end
