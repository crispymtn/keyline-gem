module Keyline
  class Imposing
    include Resource
    include Writeable::Resource

    attributes :production_path_id, :printing_technique, :maximum_number_of_mups_per_sheet, :imposing_mode, :preferred_printer_id
    writeable_attributes :printing_technique, :maximum_number_of_mups_per_sheet, :imposing_mode, :preferred_printer_id
    associations :master_signatures, :signatures
  end
end
