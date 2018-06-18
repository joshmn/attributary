module Attributary
  module Types
    class IntegerType < Type
      def self.cast_to(value)
        value.to_i
      end
    end
  end
end
