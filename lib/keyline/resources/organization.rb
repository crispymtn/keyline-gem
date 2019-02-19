module Keyline
  class Organization
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    path_prefix :customer_relations

    attributes :name, :reference, :debitor_identifier, :creditor_identifier,
      :preferred_locale, :tax_identifier, :credit_limit, :deleted_at

    writeable_attributes :name, :reference, :debitor_identifier, :creditor_identifier,
      :preferred_locale, :tax_identifier, :credit_limit

    associations :people, :address_announcements
  end
end
