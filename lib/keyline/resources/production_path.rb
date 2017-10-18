module Keyline
  class ProductionPath
    include Resource
    include Writeable::Resource
    extend  Resource::ClassMethods
    extend  Writeable::Resource::ClassMethods

    attributes :state, :circulation, :selected_for_production,
      :show_in_offer, :production_costs, :costs_per_unit, :costs_per_thousand, :total,
      :margin, :discount, :discounted_total, :outsourced, :keep_total,
      :contribution_margin_for_inhouse_costs, :contribution_margin_for_external_costs, :margin_stepping

    writeable_attributes :selected_for_production, :show_in_offer, :total, :margin, :discount, :outsourced,
      :keep_total, :margin_stepping
      
    associations :circulations
  end
end
