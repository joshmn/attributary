module Attributary
  module DSL
    module Helpers
      def attributary(&block)
        block.call(_attributary_config)
      end

      def _attributary_config
        @_attributary_config ||= Attributary::Config.new
      end

      def _attributary_attribute_set
        @_attributary_attribute_set ||= {}
      end

      def _attributary_errors
        @_attributary_errors ||= {}
      end

      def attributary_errors
        _attributary_errors
      end

      def _attributary_attributes
        hash = {}
        _attributary_attribute_set.keys.each do |k|
          hash[k] = instance_variable_get(:"@#{k}")
        end
        hash
      end

      def _attributary_valid?
        _attributary_errors.empty?
      end

    end
  end
end