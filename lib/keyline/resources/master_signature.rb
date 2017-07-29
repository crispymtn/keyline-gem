module Keyline
  class MasterSignature
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :name, :mode, :folding_pattern, :layout, :first_page, :last_page
    writeable_attributes :name, :mode, :first_page, :last_page
    associations :signatures
  end
end
