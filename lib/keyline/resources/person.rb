module Keyline
  class Person
    include Resource
    include Writeable::Resource

    path_prefix :customer_relations

    attributes :name, :reference, :email, :debitor_identifier, :creditor_identifier,
      :preferred_locale, :tax_identifier, :deleted_at

    writeable_attributes :name, :reference, :email, :debitor_identifier,
      :creditor_identifier, :preferred_locale, :tax_identifier

    def path
      Array.new.tap do |segments|
        segments << @parent.path if @parent
        segments << self.class.path_prefix if !@parent
        segments << self.name_in_path
        segments << self.id if self.persisted?
      end.join('/')
    end

    # Provides a possiblity for the given resource
    # to overwrite paths based on HTTP verb
    alias_method :path_for_index,   :path
    alias_method :path_for_show,    :path
    alias_method :path_for_create,  :path
    alias_method :path_for_update,  :path
    alias_method :path_for_destroy, :path
  end
end
