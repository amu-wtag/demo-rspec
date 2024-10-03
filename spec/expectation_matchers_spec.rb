describe 'Expectation Matchers' do
  describe '** Equivalence matchers' do
    it 'will match loose equality with #eq' do
      a = 'hello'
      b = 'hello'

      expect(a).to eq(b)
      expect(a).to be == b

      c = 11
      d = 11.0

      expect(c).to eq(d)
    end

    it 'will match value equality with #eql' do
      a = 'hello'
      b = 'hello'

      expect(a).to eql(b)

      c = 11
      d = 11.0

      expect(c).not_to eql(d) # will raise error
    end

    it 'will match identity equality with #equal' do
      a = 'hello'
      b = 'hello'

      expect(a).not_to equal(b) # will raise error

      c = 11
      d = 11.0

      expect(c).not_to equal(d) # will raise error
    end
  end

  describe '** Truthiness matchers' do
    it 'will match truthy/falsey' do
      expect(true).to be_truthy
      expect(false).to be_falsey
      expect(nil).to be_falsey
      expect(nil).to be_nil
      expect(0).to be_truthy
    end
  end

  describe '** Numeric comparison matchers' do
    it 'will match less then/greater than' do
      expect(10).to be > 9
      expect(10).to be >= 10
      expect(10).to be <= 10
      expect(10).to be < 15
    end

    it 'will match numeric ranges' do
      expect(10).to be_between(5, 10).inclusive
      expect(10).not_to be_between(5, 10).exclusive
      # The matcher be_within(1) means that the actual value can differ from the expected value by at most 1.
      expect(10).to be_within(1).of(11)
      expect(5..10).to cover(9)
    end
  end

  describe '** Collection Matchers' do
    it 'will match arrays' do
      ar = [1, 2, 3]

      expect(ar).to include(3)
      expect(ar).to include(3, 1)

      expect(ar).to start_with(1)
      expect(ar).to end_with(3)

      expect(ar).to match_array([2, 1, 3])
      expect(ar).not_to match_array([1, 2])
    end

    it 'will match strings' do
      str = 'welldev'

      expect(str).to include('dev')
      expect(str).to include('ell', 'ev')

      expect(str).to start_with('well')
      expect(str).to end_with('dev')
    end

    it 'it will match hashes' do
      hash = { a: 1, b: 2, c: 3 }
      expect(hash).to include(:a)
      expect(hash).to include(a: 1)

      expect(hash).to include(a: 1, c: 3)
      expect(hash).to include({ a: 1, c: 3 })
    end
  end

  describe '** Othere useful matchers' do
    it 'will match strings with a regex' do
      str = 'The order has been received'
      expect(str).to match(/order(.+)received/)
      expect('123').to match(/\d{3}/)
      expect(123).not_to match(/\d{3}/)

      email = 'ahnaf@welldev.io'
      regex = /^[A-Za-z0-9_-]+@[A-Za-z]+\.[A-Za-z]{2,3}$/
      expect(email).to match(regex)
    end
    it 'will match object types' do
      expect('test').to be_instance_of(String)
      expect('test').to be_an_instance_of(String)

      expect('test').to be_kind_of(String)
      expect('test').to be_a_kind_of(String)

      expect('test').to be_a(String)
      expect([1, 2, 34]).to be_an(Array)
    end

    it 'will match anything with #satisfy' do
      expect(6).to satisfy do |val|
        val >= 5 && val <= 10 && val.even?
      end
    end
  end

  describe '** Predicate matchers' do
    it 'will match be_* custom methods ending in ?' do
      # with built-in methods
      expect([]).to be_empty # [].empty?
      expect(1).to be_integer # 1.integer?
      expect(0).to be_zero # 0.zero?
      expect(13).to be_nonzero # 13.nonzero?
      expect(3).to be_odd # 3.odd?
      expect(2).to be_even # 2.even?

      # with custom methods
      class Product
        def visible?
          true
        end
      end
      product = Product.new
      expect(product).to be_visible
      expect(product.visible?).to be true
      expect(product.visible?).to be_truthy
    end

    it 'will match have_* to custom methods like has_*' do
      # with built-in methods
      hash = { a: 1, b: 2 }
      expect(hash).to have_key(:a)
      expect(hash).to have_value(2)

      # with custom methods
      class Customer
        def has_pending_order?
          true
        end
      end
      customer = Customer.new
      expect(customer).to have_pending_order
      expect(customer.has_pending_order?).to be true
      expect(customer.has_pending_order?).to be_truthy
    end
  end

  describe '** Observation matchers' do
    it 'will match when events change object attributes' do
      # calls the test before the block, then again after the block
      ar = []
      expect { ar << 1 }.to change(ar, :empty?).from(true).to(false)

      class WebsiteHits
        attr_accessor :count

        def initialize
          @count = 0
        end

        def increment
          @count += 1
        end
      end
      hits = WebsiteHits.new
      expect { hits.increment }.to change(hits, :count).from(0).to(1)
    end

    it 'will match when errors are raised ' do
      expect { 1 / 0 }.to raise_error(ZeroDivisionError)
      expect { 1 / 0 }.to raise_error.with_message('divided by 0')
    end
  end
end
