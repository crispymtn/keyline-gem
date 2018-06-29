module Keyline
  class Person
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    path_prefix :customer_relations

    attributes :name, :reference, :email, :debitor_identifier, :creditor_identifier,
      :preferred_locale, :tax_identifier, :deleted_at

    writeable_attributes :name, :reference, :email, :debitor_identifier,
      :creditor_identifier, :preferred_locale, :tax_identifier
  end
end
