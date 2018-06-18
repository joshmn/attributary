module Attributary
  module Types
    class ArrayType < Type
      def self.cast_to(value)
        value.to_a
      end
    end
  end
end
