module Keyline::Production
  class TaskExecution
    include Jeweler::Resource

    attributes :performer_id, :phase, :started_at, :finished_at, :duration
  end
end
