module Keyline
  class PrintDataFile
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :product_id, :component_id, :kind, :state, :progress, :uri, :preview_path, :filesize, :first_page, :last_page
    writeable_attributes :kind, :state, :progress, :uri, :preview_path, :filesize, :first_page, :last_page
    associations :print_data_errata
  end
end
