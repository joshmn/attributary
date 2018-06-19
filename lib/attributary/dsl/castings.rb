module Attributary
  module DSL
    module Castings

      def _attributary_cast_to(type, value)
        cast_klass = _attributary_cast_class(type)
        cast_klass.cast_to(value)
      end

      def _attributary_cast_class(type)
        cast_klass_name = _attributary_cast_class_name(type)
        cast_klass = cast_klass_name.safe_constantize
        if cast_klass.nil?
          raise NameError, "#{cast_klass_name} is not a valid type."
        end
        unless cast_klass.respond_to?(:cast_to)
          raise NoMethodError, "#{cast_klass} should have a class-method of cast_to"
        end
        cast_klass
      end

      def _attributary_cast_class_name(type)
        "Attributary::Types::#{type.to_s.split('_').map(&:capitalize).join}Type"
      end

    end
  end
end