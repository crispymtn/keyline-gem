module Keyline
	class RawMaterialRequirement
	  include Jeweler::Resource
  
	  attributes :material_kind, :user_selectable, :material_revealing_property,
	  :formula, :unit
	end
end