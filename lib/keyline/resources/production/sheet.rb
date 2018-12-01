module Keyline::Production
  class Sheet
    include Jeweler::Resource

    attributes :mode, :printing_technique, :imposing_mode, :repeats,
      :dimensions, :grain, :layout

    def box
      @box ||= Keyline::Box.from_json(self.layout)
    end
  end
end
