module Attributary
  module Types
    class FloatType < Type
      def self.cast_to(value)
        value.to_f
      end
    end
  end
end
