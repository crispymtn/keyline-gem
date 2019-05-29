module Keyline
  class User
    include Jeweler::Resource

    path_prefix :configuration

    attributes :first_name, :name, :email
  end
end
