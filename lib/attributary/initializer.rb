module Attributary
  module Initializer
    def initialize(options = {})
      attributary_initialize(options)
    end

    def attributary_initialize(options = {})
      options.each do |k, v|
        send("#{k}=", v) if attribute_set[k]
      end
    end
  end
end
