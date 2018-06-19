module Attributary
  module DSL
    class AttributaryError
      attr_reader :name, :klass, :message
      def initialize(name, klass, message)
        @name = name
        @klass = klass
        @message = message
      end
    end

  end
end
