module Keyline:Production
  class StockFinishing
    include Jeweler::Resource

    attributes :kind, :common, :permitted_finishable_type, :properties

    def path
      Array.new.tap do |segments|
        segments << (@parent&.path || 'configuration')
        segments << 'stock_finishings'
        segments << self.id if self.persisted?
      end.join('/')
    end
    alias_method :path_for_index, :path
  end
end
