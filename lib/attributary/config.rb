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
    attr_accessor :dsl_name, :strict_mode

    def initialize
      @dsl_name = :attribute
      @strict_mode = false
    end

    def strict_mode?
      @strict_mode
    end

  end
end