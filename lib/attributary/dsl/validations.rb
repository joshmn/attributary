module Attributary
  module DSL
    module Validations

      def _attributary_handle_error(attribute, value, type, options = {})
        message = options[:message] || "#{attribute} value #{value} is invalid."
        error = _attributary_config.send("#{type}_error")
        if error.is_a?(Proc)
          error = error.call(attribute, value)
        end
        if quiet_errors?
          _add_attributary_error(attribute, error.class, message)
          return
        end
        raise error, message
      end

      def _attributary_check_collection(attribute, value, collection)
        unless collection.include?(value)
          _attributary_handle_error(attribute, value, :collection, :message => "Attribute #{attribute} `#{value}' is not in the collection #{collection}")
          return false
        end
        true
      end

      def _attributary_validate_attribute(attribute, value, validator)
        return true if validator.nil?
        unless validator.call(value)
          _attributary_handle_error(attribute, value, :validation)
          false
        end
        true
      end

      def _add_attributary_error(name, klass, message)
        self._attributary_errors[name] = AttributaryError.new(name, klass, message)
      end

      def quiet_errors?
        !_attributary_config.raise_errors?
      end
    end
  end
end