require_relative 'lib/attributary'

Attributary.configure do |c|
  c.dsl_name = :donkey
end

class Character
  include Attributary::DSL

  attribute :gender, :symbol, default: :male, validates: proc { |value| [:male, :female].include?(value) }
end

c = Character.new
puts c.gender
c.gender = 'female'
puts c.gender