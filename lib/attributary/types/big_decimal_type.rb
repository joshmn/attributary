module Attributary
  module Types
    class BigDecimal < Type
      def self.cast_to(value)
        BigDecimal(value.to_s)
      end
    end
  end
end
