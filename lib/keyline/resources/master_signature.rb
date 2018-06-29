module Keyline
  class MasterSignature
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :name, :mode, :kind, :folding_pattern, :layout, :first_page, :last_page
    writeable_attributes :name, :mode, :kind, :folding_pattern, :layout, :first_page, :last_page
    associations :signatures

    def box
      @box ||= Box.from_json(self.layout)
    end
  end
end
