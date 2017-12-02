module Keyline
  class Component
    include Resource
    include Writeable::Resource

    attributes :name, :number_of_pages, :closed_dimensions, :page_arrangement, :front_colors, :back_colors
    writeable_attributes :name, :number_of_pages, :closed_dimensions, :page_arrangement, :front_colors, :back_colors

    associations :finishings, :imposings, :print_data_files,
      :stock_finishings, :desired_paper_properties
  end
end
