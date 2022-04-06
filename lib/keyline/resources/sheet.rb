module Keyline
  class Sheet
    include Jeweler::Resource

    attributes :mode, :printing_technique, :layout, :imposing_id, :repeats, :imposing_mode, :dimensions,
      :kind, :grain, :cutting, :connected_mups_after_cutting, :cropping, :cropping_margin, :mup_orientation

    def box
      @box ||= Box.from_json(self.layout)
    end
  end
end
