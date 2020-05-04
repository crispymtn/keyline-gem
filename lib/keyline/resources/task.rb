module Keyline
  class Task
    include Jeweler::Resource

    attributes :kind, :workable_id, :workable_type, :means_of_production_id, :phase, :state,
      :outsourced, :inline, :checkpoint, :duration_for_preparations,
      :duration_for_execution, :duration_for_cleanup, :duration_for_pause_until_next_task,
      :manufactured_product, :product_processing, :amount_of_wasted_manufactured_products,
      :minimum_viable_amount_of_manufactured_products, :amount_of_manufactured_products,
      :actual_duration_for_preparations, :actual_duration_for_execution, :actual_duration_for_cleanup,
      :product_id, :costs_per_hour, :material_costs, :actual_material_costs, :additional_external_costs,
      :actual_additional_external_costs

    associations :material_demands
    singleton_associations :means_of_production
  end
end
