module Keyline
  module Finders
    def where(attributes)
      matching_objects = objects

      attributes.each_pair do |attribute, value|
        begin
          matching_objects.select! { |o| o.send(attribute) == value }

        rescue NoMethodError
          raise Keyline::Errors::UnknownAttributeError,
            "Attribute #{attribute} is not defined for #{o.class}"
        end
      end

      return matching_objects
    end

    def find_by(attributes)
      where(attributes).first
    end
  end
end
