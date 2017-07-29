module Keyline
  class ProductionJunction
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :production_path_id, :printing_technique, :maximum_number_of_mups_per_sheet, :imposing_mode, :preferred_printer_id
    writeable_attributes :printing_technique, :maximum_number_of_mups_per_sheet, :imposing_mode, :preferred_printer_id
    associations :master_signatures
  end
end
