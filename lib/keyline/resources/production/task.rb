module Keyline::Production
  class Task
    include Jeweler::Resource

    path_prefix '/production'

    attributes :kind, :workable_id, :workable_type, :phase, :state, :outsourced, :inline, :checkpoint,
      :duration_for_preparations, :duration_for_execution, :duration_for_cleanup, :duration_for_pause_until_next_task,
      :manufactured_product, :product_processing,
      :minimum_viable_amount_of_manufactured_products, :amount_of_manufactured_products, :amount_of_wasted_manufactured_products

    associations :material_demands
  end
end
