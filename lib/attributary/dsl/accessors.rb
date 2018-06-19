module Attributary
  module DSL
    module Accessors

      define_method(Attributary.configuration.dsl_name) do |name, type, options = {}|
        options[:type] = type
        _attributary_attribute_set[name] = options
        _attributary_writer(name, type, options)
        _attributary_reader(name, type, options)
      end

      def _attributary_writer(name, type, options)
        define_method("#{name}=") do |value|
          value = self.class._attributary_cast_to(type, value) unless self.class._attributary_config.strict_mode?
          write = true
          write = self.class._attributary_check_collection(name, value, options[:collection]) if options[:collection].is_a?(Array)
          write = self.class._attributary_validate_attribute(name, value, options[:validate]) if options[:validate].is_a?(Proc)
          if options[:validate].is_a?(Symbol)
            unless send(options[:validate])
              self.class._attributary_handle_error(name, value, :validation)
              write = false
            end
          end
          if write
            instance_variable_set(:"@#{name}", value)
            self.class._attributary_errors.delete(name)
          end
        end
      end

      def _attributary_reader(name, type, options)
        define_method(name) do
          instance_variable_get(:"@#{name}") || self.class._attributary_default_for_method(type, options[:default])
        end
        if type == :boolean
          define_method("#{name}?") do
            send(name.to_s)
          end
        end
      end

      def _attributary_default_for_method(type, value)
        return nil if value.nil?
        _attributary_cast_to(type, value)
      end

    end
  end
end