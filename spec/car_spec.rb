require 'car'
require 'shared_examples/a_standard_vehicle'

RSpec.describe Car do
  # describe 'attributes' do
  #   # before hooks
  #   # before(:example) do
  #   #   @car = Car.new
  #   #   puts 'before example***'
  #   # end

  #   # let is better than "before" for setting up instance variables
  #   let(:car) { Car.new }

  #   # subject { Car.new }
  #   # This does the same as let(:subject) { Car.new }

  #   # Skipping the test with prepending x before it
  #   xit 'allows reading and writing for :make' do
  #     car.make = 'Test'
  #     # expect(car.make).to eq('Test')
  #   end

  #   it 'allows reading and writing for :year' do
  #     # Skipping the test with skip
  #     skip('Skipping because I want to!')
  #     car.year = 9999
  #     expect(car.year).to eq(9999)
  #   end

  #   it 'allows reading and writing for :color' do
  #     car.color = 'white'
  #     expect(car.color).to eq('white')
  #   end

  #   it 'allows reading for wheels :wheels' do
  #     expect(car.wheels).to eq(4)
  #   end

  #   # Pending test (not yet implemented)
  #   it 'allows writing for :doors'
  # end

  it_behaves_like('a standard vehicle')

  # dot(.) describes class methods
  describe '.colors' do
    let(:colors) { %w[blue black red green] }
    it 'returns an array of color names' do
      expect(Car.colors).to match_array(colors)
    end
  end

  # Hash(#) describes instance methods
  describe '#full_name' do
    let(:honda) { Car.new(make: 'Honda', year: 2004, color: 'blue') }
    let(:new_car) { Car.new }
    it 'returns a string in the expected format' do
      expect(honda.full_name).to eq('2004 Honda (blue)')
    end

    context 'when initialized with no arguments' do
      it 'returns a string using default values' do
        expect(new_car.full_name).to eq('2007 Volvo (unknown)')
      end
    end
  end
end
