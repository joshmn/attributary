require 'attributary/dsl/accessors'
require 'attributary/dsl/castings'
require 'attributary/dsl/error'
require 'attributary/dsl/helpers'
require 'attributary/dsl/validations'

module Attributary
  module DSL

    def self.included(base)
      base.extend ClassMethods
      base.include InstanceMethods
    end

    module InstanceMethods
      def attributary_errors
        self.class._attributary_errors
      end
    end

    module ClassMethods
      include Accessors
      include Castings
      include Helpers
      include Validations
    end
  end
end
