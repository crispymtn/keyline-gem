module Keyline
  class AccountingCategory
    include Jeweler::Resource

    attributes :name, :number, :invoice_kind, :tax_rate
  end
end
