module Keyline
  class MaterialStorageArea
    include Resource
    include Writeable::Resource

    path_prefix :warehouse
    attributes :name, :reference, :kind, :created_at, :updated_at
    writeable_attributes :name, :kind
  end
end
