module Keyline::Production
  class MeansOfProduction
    include Jeweler::Resource
    
    attributes :printery_id, :name, :kind, :gripper_margin, :gripper_position,
      :minimum_dimensions, :maximum_dimensions, :minimum_grammage, :maximum_grammage,
      :double_gripper, :material_storage_area_id, :facility_id, :hardware_identifier
  end
end
