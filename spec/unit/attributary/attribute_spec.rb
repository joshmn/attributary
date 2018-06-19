require 'spec_helper'

RSpec.describe Attributary do

  let(:klass) { Character.new }

  context 'reading and writing' do
    it "responds to first_name" do
      expect(klass.respond_to?(:first_name)).to eq(true)
    end

    it "responds to first_name=" do
      expect(klass.respond_to?(:"first_name=")).to eq(true)
    end

    it "reads and writes first_name" do
      expect(klass.first_name).to eq("Peter")
      klass.first_name = "Bob"
      expect(klass.first_name).to eq("Bob")
    end

    it "doesn't have a default last_name" do
      expect(klass.last_name).to eq(nil)
      klass.last_name = "Panama"
      expect(klass.last_name).to eq("Panama")
    end
  end

  context 'casting' do
    it "casts the default" do
      expect(klass.age.class).to eq(Integer)
    end

    it 'casts an incorrect type to the correct type' do
      klass.age = '12'
      expect(klass.age).to eq(12)
    end
  end


  context 'options#collection' do
    it 'raises an error if invalid' do
      expect {
        klass.favorite_color = 'white'
      }.to raise_error Attributary::CollectionValidationError
    end

    it 'does not cast' do
      expect(klass.favorite_color).to eq(nil)
      klass.favorite_color = :green
      expect(klass.favorite_color).to eq(nil)
    end
  end

  context 'options#validates' do
    it 'validates with a proc' do
      expect {
        klass.favorite_language = 'python'
      }.to raise_error Attributary::ValidationError
    end
    it 'validates with a method' do
      expect {
        klass.least_favorite_language = 'ruby'
      }.to raise_error Character::CustomError
    end
  end

  context 'with initializing' do
    let(:klass) { Person.new(:last_name => "Cool") }

    it 'has a default first_name' do
      expect(klass.first_name).to eq("Kyle")
      expect(klass.last_name).to eq("Cool")
    end
  end

  context 'serializer' do
    let(:klass) { Fish.new }

    it 'returns a hash of the instance variables' do
      expect(klass.as_json).to eq({:first_name => "Scooby", :last_name => "Doo"})
    end
  end

  context 'does not raise error' do
    let(:klass) { Food.new }

    it 'is invalid but shuts up about it' do
      klass.type = 'sugar'
      expect(klass.type).to eq("vegetable")
      expect(klass.attributary_errors.size).to eq(1)
    end
  end

end