module Keyline
  class Recipient
    include Jeweler::Resource

    attributes :name, :tax_identifier, :email, :reference, :debitor_identifier,
      :creditor_identifier, :preferred_locale, :credit_limit
  end
end
