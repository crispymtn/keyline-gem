module Keyline
  class Finishing
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :kind
    writeable_attributes :confirmed_at, :state
    associations :finishing_properties
  end
end
