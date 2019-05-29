module Keyline::Production
  class Task
    include Jeweler::Resource

    path_prefix :production, overwrite_parent_path: false

    attributes :kind, :workable_id, :workable_type, :means_of_production_id, :phase, :state,
      :outsourced, :inline, :checkpoint, :duration_for_preparations,
      :duration_for_execution, :duration_for_cleanup, :duration_for_pause_until_next_task,
      :manufactured_product, :product_processing, :amount_of_wasted_manufactured_products,
      :minimum_viable_amount_of_manufactured_products, :amount_of_manufactured_products

    associations :material_demands, :task_executions
    singleton_associations :means_of_production
  end
end
