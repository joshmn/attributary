require "bundler/setup"
require "attributary"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

class Character

  include Attributary::DSL

  class CustomError < StandardError; end

  attributary do |c|
    c.validation_error = proc do |attribute, value|
      if attribute == :least_favorite_language
        CustomError
      else
        Attributary::ValidationError
      end
    end
    c.raise_errors = true
  end

  attribute :first_name, :string, :default => "Peter"
  attribute :last_name, :string
  attribute :age, :integer, :default => '1'
  attribute :favorite_color, :string, :collection => ['red', 'blue', 'green']
  attribute :favorite_language, :string, :validate => proc { |value| value == 'ruby' }
  attribute :least_favorite_language, :string, :validate => :check_least_favorite_language

  private

  def check_least_favorite_language
    least_favorite_language == 'ruby'
  end

end

class Person

  include Attributary::DSL
  include Attributary::Initializer

  attribute :first_name, :string, :default => "Kyle"
  attribute :last_name, :string
end


class Fish

  include Attributary::DSL
  include Attributary::Initializer
  include Attributary::Serializer

  attribute :first_name, :string, :default => "Scooby"
  attribute :last_name, :string, :default => "Doo"

end

class Food
  include Attributary::DSL

  attribute :type, :string, :collection => ['fruit', 'vegetable'], :default => 'vegetable'
end