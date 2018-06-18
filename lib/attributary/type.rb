module Attributary
  module Types
    class Type
      def self.cast_to(value)
        value
      end
    end
  end
end

require 'types/array_type'
require 'types/big_decimal_type'
require 'types/boolean_type'
require 'types/float_type'
require 'types/hash_type'
require 'types/integer_type'
require 'types/string_type'
require 'types/symbol_type'
