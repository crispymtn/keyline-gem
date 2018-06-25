module Keyline
  class User
    include Resource
    include SingletonResource

    attributes :first_name, :name, :email
  end
end
