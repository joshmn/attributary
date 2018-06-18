module Attributary
  module Types
    class StringType < Type
      def self.cast_to(value)
        value.to_s
      end
    end
  end
end
