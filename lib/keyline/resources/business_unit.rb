module Keyline
  class BusinessUnit
    include Jeweler::Resource

    path_prefix :configuration

    attributes :id, :name, :printery_id, :invoice_reply_to_email, :offer_reply_to_email,
      :material_delivery_reply_to_email, :terms, :additional_document_information, :send_email_copies,
      :email_signature, :order_confirmation, :archive_email, :created_at, :updated_at

    associations :carriers
  end
end
