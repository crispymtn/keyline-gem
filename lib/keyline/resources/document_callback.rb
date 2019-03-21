module Keyline
  class DocumentCallback
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :printable_id, :printable_type, :kind, :url
    writeable_attributes :kind, :url
  end
end
