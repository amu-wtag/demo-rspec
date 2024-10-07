describe 'Doubles' do
  it 'allow stubbing methods' do
    dbl = double('Chant')
    allow(dbl).to receive(:hey!) # returns nil
    expect(dbl).to respond_to(:hey!)
  end

  it 'allow stubbing a response with a block' do
    dbl = double('Chant')
    allow(dbl).to receive(:hey!) { 'Ho!' }
    expect(dbl.hey!).to eq('Ho!')
  end

  it 'allow stubbing responses with #and_return' do
    dbl = double('Chant')
    allow(dbl).to receive(:hey!).and_return('Ho!') # preferred syntax
    expect(dbl.hey!).to eq('Ho!')
  end

  it 'allow stubbing multiple methods with hash syntax' do
    dbl = double('Person')
    allow(dbl).to receive_messages(full_name: 'Mary Smith', initials: 'MTS')
    expect(dbl.full_name).to eq('Mary Smith')
    expect(dbl.initials).to eq('MTS')
  end

  it 'allows stubbing with a hash argument to #double' do
    dbl = double('Person', full_name: 'Mary Smith', initials: 'MTS')
    expect(dbl.full_name).to eq('Mary Smith')
    expect(dbl.initials).to eq('MTS')
  end

  context 'with partial test doubles' do
    it 'allows stubbing instance methods on Ruby classes' do
      time = Time.new(2010, 1, 1, 12, 0, 0)
      allow(time).to receive(:year).and_return(1975)

      #   expect(time.to_s).to eq('2010-01-01 12:00:00 -0500')
      expect(time.year).to eq(1975)
    end

    it 'allows stubbing instance methods on custom classes' do
      class SuperHero
        attr_accessor :name
      end

      hero = SuperHero.new
      hero.name = 'Superman'
      expect(hero.name).to eq('Superman')

      allow(hero).to receive(:name).and_return('Clark Kent')
      expect(hero.name).to eq('Clark Kent')
    end

    it 'allows stubbing class methods on Ruby Classes' do
      #   fixed = Time.new(2010, 1, 1, 12, 0, 0)
      #   allow(Time).to receive(:now).and_return(fixed)

      #   expect(Time.now).to eq(fixed)
      #   expect(Time.now.to_s).to eq('2010-01-01 12:00:00 -0500')
      #   expect(Time.now.year).to eq(2010)
    end

    it 'allows stubbing database calls a mock object' do
      class Customer
        attr_accessor :name

        def self.find; end
      end
      dbl = double('Mock Customer')
      allow(dbl).to receive(:name).and_return('Bob')
      allow(Customer).to receive(:find).and_return(dbl)

      customer = Customer.find
      expect(customer.name).to eq('Bob')
    end

    it 'allows stubbing database calls with many mock objects' do
      class Customer
        attr_accessor :name

        def self.all; end
      end

      c1 = double('First Customer', name: 'Bob')
      c2 = double('Second Customer', name: 'Mary')

      allow(Customer).to receive(:all).and_return([c1, c2])
      customers = Customer.all
      expect(customers[1].name).to eq('Mary')
    end

    it 'mocks a method' do
      car = double('Car')
      expect(car).to receive(:start).with('key').and_return(true)

      car.start('key') # we must call it
    end

    context 'with message expectations' do
      it 'expects a call and allows a response' do
        dbl = double('Chant')
        expect(dbl).to receive(:hey!).and_return('Ho!')
        dbl.hey!
      end

      it 'does not matter which order' do
        dbl = double('Multi-step Process')
        expect(dbl).to receive(:step_1)
        expect(dbl).to receive(:step_2)

        dbl.step_1
        dbl.step_2
      end

      it 'works with #ordered when order matter' do
        dbl = double('Multi-step Process')
        expect(dbl).to receive(:step_1).ordered
        expect(dbl).to receive(:step_2).ordered

        # if we call step_2 before step_1 ot will be a failure
        dbl.step_1
        dbl.step_2
      end
    end

    context 'with argument constraints' do
      it 'expects arguments will match' do
        dbl = double('Customer List')
        expect(dbl).to receive(:sort).with('name')
        dbl.sort('name')
      end

      it 'passes when any arguments are allowed' do
        dbl = double('Customer List')
        expect(dbl).to receive(:sort).with(any_args)
        dbl.sort('name')
      end

      it 'works the same with multiple arguments' do
        dbl = double('Customer List')
        expect(dbl).to receive(:sort).with('name', 'asc', true)
        dbl.sort('name', 'asc', true)
      end

      it 'allows using other matchers' do
        dbl = double('Customer List')
        expect(dbl).to receive(:sort).with(
          a_string_starting_with('n'),
          an_object_eq_to('asc') | an_object_eq_to('desc'),
          boolean
        )
        dbl.sort('name', 'desc', true)
      end
    end
  end
end
