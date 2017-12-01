module Keyline
  class SupplierContact
    include SingletonResource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :contactable_id, :contactable_type, :title, :first_name, :name, :email, :phone, :mobile, :fax, :debitor_identifier
    writeable_attributes :title, :first_name, :name, :email, :phone, :mobile, :fax, :debitor_identifier

    def name_in_params
      'contact'
    end

    def name_in_path
      'contact'
    end
  end
end
