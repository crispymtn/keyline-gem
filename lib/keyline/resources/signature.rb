module Keyline
  class Signature
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :name, :pages, :layout
    writeable_attributes :name, :pages, :layout

    def box
      @box ||= Box.from_json(@layout)
    end
  end
end
