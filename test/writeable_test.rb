require "test_helper"

class WriteableTest < Minitest::Test
  def test_that_build_on_collection_instantiates_new_object
    order = Keyline::Order.new
    product = order.products.build

    assert_equal product.class, Keyline::Product
  end

  def test_that_build_on_collection_sets_parent_on_new_object
    order = Keyline::Order.new
    product = order.products.build

    assert_equal product.parent, order
  end

  def test_that_build_on_collection_adds_built_child_to_the_collection
    order = Keyline::Order.new
    product = order.products.build

    assert_equal order.products.count, 1
    assert_equal product, order.products.first
  end
end
