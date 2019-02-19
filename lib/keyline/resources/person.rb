module Keyline
  class Person
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    path_prefix :customer_relations, overwrite_parent_path: false

    attributes :salutation, :first_name, :name, :reference, :email, :debitor_identifier,
      :creditor_identifier, :preferred_locale, :tax_identifier,
      :phone, :fax, :mobile, :credit_limit, :deleted_at

    writeable_attributes :salutation, :first_name, :name, :reference, :email,
      :debitor_identifier, :creditor_identifier, :preferred_locale, :tax_identifier,
      :phone, :fax, :mobile, :credit_limit

    # Provides a possiblity for the given resource
    # to overwrite paths based on HTTP verb
    alias_method :path_for_index,   :path
    alias_method :path_for_show,    :path
    alias_method :path_for_create,  :path
    alias_method :path_for_update,  :path
    alias_method :path_for_destroy, :path
  end
end
