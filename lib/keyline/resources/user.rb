module Keyline
  class User
    include Jeweler::Resource

    attributes :first_name, :name, :email
  end
end
