module Attributary
  def self.configuration
    @configuration || Config.new
  end

  def self.configuration=(val)
    @configuration = val
  end

  def self.configure
    self.configuration ||= Config.new
    yield(configuration)
  end

  class Config
    attr_accessor :validation_error, :collection_error, :strict_mode, :dsl_name, :raise_errors
    def initialize
      @validation_error = ::Attributary::ValidationError
      @collection_error = ::Attributary::CollectionValidationError
      @strict_mode = false
      @dsl_name = :attribute
      @raise_errors = false
    end

    def raise_errors?
      @raise_errors
    end

    def strict_mode?
      @strict_mode
    end
  end
end
