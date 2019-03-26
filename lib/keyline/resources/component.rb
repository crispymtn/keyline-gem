module Keyline
  class Component
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :name, :number_of_pages, :closed_dimensions, :page_arrangement, :front_colors, :back_colors
    writeable_attributes :name, :number_of_pages, :closed_dimensions, :page_arrangement, :front_colors, :back_colors

    associations :finishings, :imposings, :print_data_files, :stock_finishings,
      :material_presets

    singleton_associations :desired_substrate_properties
  end
end
