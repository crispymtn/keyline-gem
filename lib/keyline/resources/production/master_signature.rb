module Keyline::Production
  class MasterSignature
    include Jeweler::Resource

    attributes :name, :mode, :kind, :folding_pattern, :layout, :first_page, :last_page
    associations :signatures

    def box
      @box ||= Box.from_json(self.layout)
    end
  end
end
