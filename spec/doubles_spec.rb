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
  end
end
