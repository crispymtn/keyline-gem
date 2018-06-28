module Keyline
  class Order
    include Resource
    include Writeable::Resource

    path_prefix :sales

    attributes :business_unit_id, :reference, :custom_references, :custom_offer_text,
      :costs, :due_at, :confirmed_at, :archived_at, :offer_sent_at, :cleared_at,
      :state, :shipping_costs, :mixed_shipping, :shipping_costs_billing_mode

    writeable_attributes :confirmed_at, :state, :due_at, :custom_references, :custom_offer_text, :customer_id

    associations :assignments, :products, :packagings
  end
end
