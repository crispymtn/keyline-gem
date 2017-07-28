require "test_helper"

class ResourceTest < Minitest::Test
  def test_that_paths_are_build_correctly
    assert_equal 'conception/products', Keyline::Product.path
    assert_equal 'sales/orders', Keyline::Order.path
    assert_equal 'conception/products/1234/components', Keyline::Component.new({}, Keyline::Product.new('id' => 1234)).path
    assert_equal 'conception/products/1234/components/5678', Keyline::Component.new({'id' => 5678}, Keyline::Product.new('id' => 1234)).path
  end
end
