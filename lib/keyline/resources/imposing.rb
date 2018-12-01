module Keyline
  class Imposing
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :production_path_id, :printing_technique, :maximum_number_of_mups_per_sheet,
      :imposing_mode, :preferred_printer_id, :default_margin, :default_stock_folding_pattern_id,
      :auto_signature_generation, :disable_folding, :allow_printing_on_gripper

    writeable_attributes :printing_technique, :maximum_number_of_mups_per_sheet,
      :imposing_mode, :preferred_printer_id, :default_margin, :default_stock_folding_pattern_id,
      :auto_signature_generation, :disable_folding, :allow_printing_on_gripper

    associations :master_signatures
    singleton_associations :substrate
  end
end
