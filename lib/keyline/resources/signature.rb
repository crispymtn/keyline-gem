module Keyline
  class Signature
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :name, :pages
    writeable_attributes :name, :pages
  end
end
