module Keyline
  class Paper
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :stock_paper_id, :production_junction_id, :name, :dimensions, :precut_dimensions,
      :grain, :grammage, :color_saturation, :thickness, :kind, :environmental_certification,
      :texture, :color, :automatically_selected

    writeable_attributes :stock_paper_id, :precut_dimensions

    def path_for_create
      # paper is a singleton resource, but path always assumes it's a collection,
      # so we chop of the 's' at the end
      super[0..-2]
    end
  end
end
