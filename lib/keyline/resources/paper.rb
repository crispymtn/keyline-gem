module Keyline
  class Paper
    include SingletonResource
    include Writeable::Resource

    attributes :stock_paper_id, :imposing_id, :name, :dimensions, :precut_dimensions,
      :grain, :grammage, :color_saturation, :thickness, :kind, :environmental_certification,
      :texture, :color, :automatically_selected

    writeable_attributes :stock_paper_id, :precut_dimensions
  end
end
