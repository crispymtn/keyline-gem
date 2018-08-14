module Keyline
  class Signature
    include Jeweler::Resource

    attributes :name, :pages, :layout

    def box
      @box ||= Box.from_json(@layout)
    end
  end
end
