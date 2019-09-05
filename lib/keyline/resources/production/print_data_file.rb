module Keyline::Production
  class PrintDataFile
    include Jeweler::Resource

    attributes :printable_id, :printable_type, :kind, :state, :progress, :uri,
      :preview_path, :filesize, :first_page, :last_page, :review_url,
      :approved_at
      
    associations :print_data_errata
  end
end
