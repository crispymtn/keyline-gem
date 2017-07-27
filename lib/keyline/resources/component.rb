module Keyline
  class Component
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    path_prefix :conception
    attributes :name, :number_of_pages, :closed_dimensions, :page_arrangement
    writeable_attributes :name, :number_of_pages, :closed_dimensions, :page_arrangement
  end
end
