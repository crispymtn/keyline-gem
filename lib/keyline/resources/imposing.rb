module Keyline
  class Imposing
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :production_path_id, :printing_technique,
      :maximum_number_of_mups_per_sheet, :imposing_mode, :cutting, :cropping,
      :cropping_margin, :connected_mups_after_cutting, :default_margin,
      :default_stock_folding_pattern_id, :auto_signature_generation,
      :allow_printing_on_gripper, :disable_folding, :mup_orientation,
      :keep_grain_when_precutting

    writeable_attributes :printing_technique,
      :maximum_number_of_mups_per_sheet, :imposing_mode, :cutting, :cropping,
      :cropping_margin, :connected_mups_after_cutting, :default_margin,
      :default_stock_folding_pattern_id, :auto_signature_generation,
      :allow_printing_on_gripper, :disable_folding, :mup_orientation,
      :keep_grain_when_precutting

    associations :master_signatures
    singleton_associations :substrate
  end
end
