module Keyline
  class Printery
    include Jeweler::Resource

    path_prefix :configuration

    attributes :id, :name, :country_code, :locale, :created_at, :updated_at
  end
end
