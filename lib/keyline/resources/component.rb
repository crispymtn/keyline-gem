module Keyline
  class Component
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :name, :number_of_pages, :closed_dimensions, :page_arrangement, :front_colors, :back_colors
    writeable_attributes :name, :number_of_pages, :closed_dimensions, :page_arrangement, :front_colors, :back_colors
    associations :finishings, :production_junctions, :print_data_files
  end
end
