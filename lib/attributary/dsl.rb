module Attributary
  module DSL
    class ValidationError < StandardError; end
    class CollectionValidationError < StandardError; end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def _attributary_attribute_set
        @_attributary_attribute_set ||= {}
      end

      def _attributary_attributes
        hash = {}
        _attributary_attribute_set.keys.each do |k|
          hash[k] = instance_variable_get(:"@#{k}")
        end
        hash
      end

      define_method(Attributary.configuration.dsl_name) do |name, type, options = {}|
        options[:type] = type
        _attributary_attribute_set[name] = options
        _attributary_reader(name, type, options)
        _attributary_writer(name, type, options)
      end

      def _attributary_reader(name, type, options)
        define_method(name) do
          instance_variable_get(:"@#{name}") || if options[:default].is_a?(Proc)
                                                  options[:default].call
                                                else
                                                  options[:default]
                                                end
        end
        if type == :boolean
          define_method("#{name}?") do
            send("#{name}")
          end
        end
      end

      def _attributary_writer(name, type, options)
        define_method("#{name}=") do |value|
          value = self.class._attributary_cast_to(type, value) unless Attributary.configuration.strict_mode?
          self.class._attributary_check_collection(value, options[:collection]) if options[:collection].is_a?(Array)
          self.class._attributary_validate_attribute(value, options[:validates])
          instance_variable_set(:"@#{name}", value)
        end
      end

      def _attributary_check_collection(value, collection)
        unless collection.include?(value)
          raise CollectionValidationError, "Value `#{value}' is not in the collection #{collection}."
        end
      end

      def _attributary_validate_attribute(value, validator)
        return true if validator.nil?
        unless validator.call(value)
          raise ValidationError, "Validator failed."
        end
      end

      def _attributary_cast_to(type, value)
        cast_klass = self._attributary_cast_class(type)
        cast_klass.cast_to(value)
      end

      def _attributary_cast_class(type)
        cast_klass_name = self._attributary_cast_class_name(type)
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

