# Attributary

Like `ActiveModel::Attributes` but not. No dependencies.

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

### Configuration

    Attributary.configure do |c|
      c.dsl_name = :donkey # defaults to :attrubute
      c.strict_mode = false # set this to `true` to skip casting in the writer method (raises TypeError)
    end
    
### Actually using it

    class Character
      include Attributary::DSL
      
      donkey :gender, :symbol, default: :male 
    end
     
    character = Character.new
    puts character.gender # :male 
    character.gender = 'female'
    puts character.gender # :female

### Initializing

Want to initialize? Cool.

    class Character
      include Attributary::Initializer
      include Attributary::DSL
      
      donkey :gender, :symbol, default: :male 
    end
    
    character = Character.new(gender: :male)
    puts character.gender # :male 
    
Have to initialize other stuff? Send a hash to attributary_initialize

    class Character
      include Attributary::Initializer
      include Attributary::DSL
      
      donkey :gender, :symbol, default: :male 
      
      def initialize(name, attributary_attributes = {})
        @name = name 
        attributary_initialize(attributary_attributes)
      end  
    end
    
    character = Character.new("Charlie", gender: :male)
    puts character.gender # :male 

### Validations

There are two types of validations. You can pass a `:collection` option, and/or you can pass a `:validates` option.

#### Using `:collection`

Simply pass an array of the possible options for the attribute.

    class Character
      include Attributary::DSL
      
      donkey :gender, :symbol, default: :male, collection: [:male, :female]
    end
    
    character = Character.new("Charlie", gender: :male)
    puts character.gender # :male 
    character.gender = :left # raises CollectionValidationError
    character.gender = :female 
    puts character.gender # :female 
    character.gender = 'male' # gets casted correctly, and doesn't raise an error. Turn this off with strict_mode
    
#### Using `:validates`

Pass a proc or a method name.

    class Character
      include Attributary::DSL
      
      donkey :gender, :symbol, default: :male, validates: proc { |value| [:male, :female].include?(value) }
    end
    
    character = Character.new("Charlie", gender: :male)
    puts character.gender # :male 
    character.gender = :left # raises CollectionValidationError
    character.gender = 'female' # gets casted correctly, and doesn't raise an error
    

### Types

Supports some really naive typecasting. [See the supported types](https://github.com/joshmn/attributary/tree/master/lib/attributary/types). Create your own by inheriting from `Attributary::Types` and naming it like `ClassNameType`

    module Attributary
      module Types
        class FriendType < Type
          def self.cast_to(value)
            Foe.new(value)
          end
        end
      end
    end

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joshmn/attributary