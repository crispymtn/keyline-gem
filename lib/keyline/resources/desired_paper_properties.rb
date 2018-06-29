module Keyline
  class DesiredPaperProperties
    include Jeweler::SingletonResource
    include Jeweler::Writeable::Resource

    attributes :component_id, :name, :dimensions, :grain, :color, :kind, :grammage, :environmental_certification
    writeable_attributes :name, :dimensions, :grain, :color, :kind, :grammage, :environmental_certification
  end
end
