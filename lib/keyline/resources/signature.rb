module Keyline
  class Signature
    include Resource
    include Writeable::Resource
  
    attributes :name, :pages, :layout
    writeable_attributes :name, :pages, :layout

    def box
      @box ||= Box.from_json(@layout)
    end
  end
end
