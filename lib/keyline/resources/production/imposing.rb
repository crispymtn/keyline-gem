module Keyline::Production
  class Imposing
    include Jeweler::Resource

    attributes :production_path_id, :printing_technique, :maximum_number_of_mups_per_sheet,
      :imposing_mode, :preferred_printer_id
  end
end
