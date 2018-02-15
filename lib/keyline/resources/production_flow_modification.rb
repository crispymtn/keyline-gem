module Keyline
  class ProductionFlowModification
    include Resource
    include Writeable::Resource

    attributes :modification, :stock_task_id, :means_of_production_id, :workable_type, :workable_id
    writeable_attributes :modification, :stock_task_id, :means_of_production_id, :workable_type, :workable_id
  end
end
