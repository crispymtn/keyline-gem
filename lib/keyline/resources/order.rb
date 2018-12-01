module Keyline
  class Order
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    path_prefix :sales

    attributes :business_unit_id, :reference, :custom_references, :custom_offer_text,
      :costs, :due_at, :confirmed_at, :archived_at, :offer_sent_at, :cleared_at,
      :state, :shipping_costs, :mixed_shipping, :shipping_costs_billing_mode,
      :customer_id, :customer_type, :contact_id

    writeable_attributes :confirmed_at, :state, :due_at, :custom_references, :custom_offer_text,
      :customer_id, :customer_type, :contact_id, :business_unit_id

    associations :assignments, :products, :packagings
    singleton_associations :address
  end
end
