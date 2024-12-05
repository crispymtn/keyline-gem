module Keyline
  class Service
    include Jeweler::Resource
    include Jeweler::Writeable::Resource

    attributes :service_template_id, :expected_quantity, :description, :project_management_url
    writeable_attributes :service_template_id, :expected_quantity, :description, :project_management_url
  end
end
