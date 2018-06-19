# Attributary

Like `ActiveModel::Attributes` or `Virtus` but not. No dependencies.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'attributary'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attributary

## Usage

```Ruby 
class Character
  include Attributary::DSL
  include Attributary::Initializer
  
  attribute :age, :integer
  attribute :description, :string, :validate => :check_description
  attribute :gender, :string, :collection => ['male', 'female', 'other']
  
  # if you don't need to initialize anything yourself, you can omit this
  def initialize(name, options = {})
    @name = name 
    attributary_attributes(options)
  end
  
  private
  
  def check_description
    description.length <= 1024
  end
end

character = Character.new("Tommy", :age => 16, :description => "Hi I am Tommy", :gender => 'male')
character.age # 16
character.description # Hi I am Tommy
character.gender # male 

character.age = 18
character.age # 18
```

Lots more info on the [Wiki](https://github.com/joshmn/attributary/wiki)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joshmn/attributary