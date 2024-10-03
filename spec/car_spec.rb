require 'car'

RSpec.describe 'Car' do
  describe 'attributes' do
    car = Car.new

    # Skipping the test with prepending x before it
    xit 'allows reading and writing for :make' do
      car.make = 'Test'
      expect(car.make).to eq('Test')
    end

    it 'allows reading and writing for :year' do
      # Skipping the test with skip
      skip('Skipping because I want to!')
      car.year = 9999
      expect(car.year).to eq(9999)
    end

    it 'allows reading and writing for :color' do
      car.color = 'white'
      expect(car.color).to eq('white')
    end

    it 'allows reading for wheels :wheels' do
      expect(car.wheels).to eq(4)
    end

    # Pending test (not yet implemented)
    it 'allows writing for :doors'
  end

  # dot(.) describes class methods
  describe '.colors' do
    it 'returns an array of color names' do
      c = %w[blue black red green]
      expect(Car.colors).to match_array(c)
    end
  end

  # Hash(#) describes instance methods
  describe '#full_name' do
    it 'returns a string in the expected format' do
      @honda = Car.new(make: 'Honda', year: 2004, color: 'blue')
      expect(@honda.full_name).to eq('2004 Honda (blue)')
    end

    context 'when initialized with no arguments' do
      it 'returns a string using default values' do
        car = Car.new
        expect(car.full_name).to eq('2007 Volvo (unknown)')
      end
    end
  end
end
