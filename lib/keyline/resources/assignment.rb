module Keyline
  class Assignment
    include Jeweler::Resource

    attributes :role
    associations :user
  end
end
