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
end
