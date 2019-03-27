module Keyline
  class Contact
    include Jeweler::Resource

    attributes :salutation, :name, :first_name, :mobile, :phone, :fax,
      :tax_identifier, :email, :reference, :credit_limit, :debitor_identifier,
      :preferred_locale
  end
end
