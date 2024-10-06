require 'truck'
require 'shared_examples/a_standard_vehicle'

RSpec.describe Truck do
  it_behaves_like('a standard vehicle')
end
