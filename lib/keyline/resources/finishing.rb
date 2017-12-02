module Keyline
  class Finishing
    include Resource
    include Writeable::Resource
  
    attributes :stock_finishing_id, :kind
    writeable_attributes :stock_finishing_id
    associations :finishing_properties
  end
end
