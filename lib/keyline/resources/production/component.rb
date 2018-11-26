module Keyline::Production
  class Component
    include Jeweler::Resource

    attributes :name, :number_of_pages, :closed_dimensions, :opened_dimensions, :page_arrangement, :front_colors, :back_colors

    associations :finishings, :imposing, :print_data_files, :master_signatures, :sheets, :substrate
  end
end
