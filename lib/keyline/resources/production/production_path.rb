module Keyline::Production
  class ProductionPath
    include Jeweler::SingletonResource

    attributes :state, :circulation, :selected_for_production,
      :show_in_offer, :production_costs, :costs_per_unit, :costs_per_thousand, :total,
      :margin, :discount, :discounted_total, :outsourced, :keep_total,
      :contribution_margin_for_inhouse_costs, :contribution_margin_for_external_costs, :margin_stepping, :tasks, :means_of_production, :material_demands

    associations :circulations, :production_flow_modifications
  end
end
