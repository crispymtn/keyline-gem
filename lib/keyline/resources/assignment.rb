module Keyline
  class Assignment
    include Resource

    attributes :role
    associations :user
  end
end
