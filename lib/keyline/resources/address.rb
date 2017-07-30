module Keyline
  class Address
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :addressable_id, :addressable_type, :addressee, :street, :number, :zip_code, :town, :country_code, :state_or_province
    writeable_attributes :addressee, :street, :number, :zip_code, :town, :country_code, :state_or_province
  end
end
