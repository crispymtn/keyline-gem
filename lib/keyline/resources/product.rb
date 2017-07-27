module Keyline
  class Product
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    path_prefix :conception
    attributes :reference, :name, :kind
    writeable_attributes :name, :kind
    associations :components
  end
end
