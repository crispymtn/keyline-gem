module Keyline
  class Paper
    include SingletonResource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :stock_paper_id, :production_junction_id, :name, :dimensions, :precut_dimensions,
      :grain, :grammage, :color_saturation, :thickness, :kind, :environmental_certification,
      :texture, :color, :automatically_selected

    writeable_attributes :stock_paper_id, :precut_dimensions
  end
end
