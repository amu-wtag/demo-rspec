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

      expect(c).to eql(d) # will raise error
    end

    it 'will match identity equality with #equal' do
      a = 'hello'
      b = 'hello'

      expect(a).to equal(b) # will raise error

      c = 11
      d = 11.0

      expect(c).to equal(d) # will raise error
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
      expect(ar).to end_with(1)

      expect(ar).to match_array([2, 1, 3])
      expect(ar).not_to match_array([1, 2])
    end

    it 'will match strings' do
      ar = [1, 2, 3]

      expect(ar).to include(3)
      expect(ar).to include(3, 1)

      expect(ar).to start_with(1)
      expect(ar).to end_with(1)

      expect(ar).to match_array([2, 1, 3])
      expect(ar).not_to match_array([1, 2])
    end
  end
end
