module Keyline
  class Printery
    include Resource

    path_prefix :configuration

    attributes :id, :name, :country_code, :default_imposing_margin, :template_access, :created_at, :updated_at,
      :formula_for_contribution_margin_for_inhouse_costs, :formula_for_contribution_margin_for_external_costs,
      :production_scheduling_days_in_advance, :production_scheduling_generations,
      :production_scheduling_meet_deadline_importance, :production_scheduling_minimize_splits_importance,
      :production_scheduling_pool_materials_importance, :production_scheduling_minimize_time_importance
  end
end
