module Attributary
  module Types
    class Type
      def self.cast_to(value)
        value
      end
    end
  end
end

require_relative 'types/array_type'
require_relative 'types/big_decimal_type'
require_relative 'types/boolean_type'
require_relative 'types/float_type'
require_relative 'types/hash_type'
require_relative 'types/integer_type'
require_relative 'types/string_type'
require_relative 'types/symbol_type'
