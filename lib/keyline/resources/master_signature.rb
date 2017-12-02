module Keyline
  class MasterSignature
    include Resource
    include Writeable::Resource
  
    attributes :name, :mode, :folding_pattern, :layout, :first_page, :last_page
    writeable_attributes :name, :mode, :first_page, :last_page, :layout
    associations :signatures

    def box
      @box ||= Box.from_json(self.layout)
    end
  end
end
