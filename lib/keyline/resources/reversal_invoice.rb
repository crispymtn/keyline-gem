module Keyline
  class ReversalInvoice
    include Jeweler::Resource
    include Jeweler::Document

    path_prefix :accounting

    attributes :recipient_id, :recipient_type, :business_unit_id, :reversed_invoice_id,
      :number, :net_total, :gross_total, :paid_at, :custom_text, :taxes, :due_at,
      :billed_at, :sent_at, :custom_references, :services_performed_at

    associations :line_items
    singleton_associations :address, :recipient, :contact, :payment_terms

    def document
      retrieve_document(self.path_for_show + '.pdf')
    end
  end
end
