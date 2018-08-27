module Keyline::Production
  class Sheet
    include Jeweler::Resource

    attributes :mode, :printing_technique, :imposing_mode, :repeats, :dimensions, :grain

    def box
      @box ||= Box.from_json(@layout)
    end
  end
end
