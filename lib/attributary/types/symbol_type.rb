module Attributary
  module Types
    class SymbolType < Type
      def self.cast_to(value)
        value.to_s.to_sym
      end
    end
  end
end
