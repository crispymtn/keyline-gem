module Keyline
  class PaymentTerm
    include Jeweler::Resource

    attributes :time_for_payment, :time_for_first_cashback,
    :first_cashback_discount, :time_for_second_cashback, :second_cashback_discount
  end
end
