module Keyline
  class Assignment
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :user_id, :role
    writeable_attributes :user_id, :role
    singleton_associations :user
  end
end
