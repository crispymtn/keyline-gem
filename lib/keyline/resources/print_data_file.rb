module Keyline
  class PrintDataFile
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :product_id, :component_id, :kind, :state, :progress, :uri,
    :preview_path, :filesize, :first_page, :last_page, :review_url,
    :approved_at

    writeable_attributes :kind, :state, :progress, :uri, :preview_path,
    :filesize, :first_page, :last_page, :review_url, :approved_at

    associations :print_data_errata
  end
end
