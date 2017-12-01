module Keyline
  class Supplier
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    path_prefix :configuration

    attributes :name, :creditor_identifier, :created_at, :updated_at, :reference, :customer_number
    writeable_attributes :name, :customer_number, :creditor_identifier

    associations :supplier_contact

    def contact
      self.supplier_contact
    end
  end
end
