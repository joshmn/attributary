module Attributary
  module Types
    class BigDecimal < Type
      def self.cast_to(value)
        BigDecimal.new(value.to_s)
      end
    end
  end
end
