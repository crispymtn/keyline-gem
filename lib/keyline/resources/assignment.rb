module Keyline
  class Assignment
    include Jeweler::Resource

    attributes :role
    singleton_associations :user
  end
end
