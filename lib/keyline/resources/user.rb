module Keyline
  class User
    include Jeweler::SingletonResource

    attributes :first_name, :name, :email
  end
end
