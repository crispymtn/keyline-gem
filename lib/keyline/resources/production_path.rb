module Keyline
  class ProductionPath
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :state, :circulation, :selected_for_production,
      :show_in_offer, :production_costs, :costs_per_unit, :costs_per_thousand, :sub_total, :total,
      :margin, :discount, :discounted_total, :outsourced, :keep_total,
      :material_costs, :shipping_costs, :weight_calculation_mode, :product_weight,
      :inhouse_costs, :external_costs

    writeable_attributes :selected_for_production, :show_in_offer, :sub_total, :margin, :discount, :outsourced,
      :keep_total, :weight_calculation_mode, :product_weight

    associations :circulations, :production_flow_modifications, :tasks

    def conceptualize!
      @client.send(:send_request, :patch, self.path_for_update + '/conceptualize')
    end
  end
end