module Attributary
  module Types
    class HashType < Type
      def self.cast_to(value)
        value.is_a?(Hash) ? value : value.to_h
      end
    end
  end
end
