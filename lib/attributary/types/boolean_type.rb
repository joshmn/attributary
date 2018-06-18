module Attributary
  module Types
    class BooleanType < Type
      def self.cast_to(value)
        if ['false', 0, '0', false, nil, ''].include?(value)
          false
        else
          true
        end
      end
    end
  end
end
