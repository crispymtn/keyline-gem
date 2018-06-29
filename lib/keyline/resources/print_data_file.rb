module Keyline
  class PrintDataFile
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :product_id, :component_id, :kind, :state, :progress, :uri, :preview_path, :filesize, :first_page, :last_page
    writeable_attributes :kind, :state, :progress, :uri, :preview_path, :filesize, :first_page, :last_page
    associations :print_data_errata
  end
end
