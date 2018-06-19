module Attributary
  module Serializer
    def self.included(base)
      base.include InstanceMethods
    end

    module InstanceMethods
      def read_attribute_for_serialization(attribute_name)
        send(attribute_name)
      end

      def as_json
        hash = {}
        self.class._attributary_attribute_set.keys.each do |key|
          hash[key] = read_attribute_for_serialization(key)
        end
        hash
      end
    end
  end
end
