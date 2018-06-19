module Attributary
  module Types
    class Type
      def self.cast_to(value)
        value
      end
    end
  end
end

require 'attributary/types/array_type'
require 'attributary/types/big_decimal_type'
require 'attributary/types/boolean_type'
require 'attributary/types/float_type'
require 'attributary/types/hash_type'
require 'attributary/types/integer_type'
require 'attributary/types/string_type'
require 'attributary/types/symbol_type'