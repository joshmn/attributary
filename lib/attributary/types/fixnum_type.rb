module Attributary
  module Types
    class FixnumType < IntegerType
      def self.cast_to(value)
        value.to_f
      end
    end
  end
end
