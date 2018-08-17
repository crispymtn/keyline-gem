module Keyline
  class ProcessingRequirement
    include Jeweler::Resource

    attributes :processing, :processed, :required
  end
end