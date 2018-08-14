module Keyline::Production
  class Component
    include Jeweler::Resource

    attributes :name, :number_of_pages, :closed_dimensions, :page_arrangement, :front_colors, :back_colors

    associations :finishings, :imposings, :print_data_files, :stock_finishings,
      :desired_paper_properties, :material_presets, :substrate
  end
end
