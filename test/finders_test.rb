require "test_helper"

class FindersTest < Minitest::Test
  def test_that_objects_in_collections_get_found_with_where
    order = Keyline::Order.new
    order.products.build(name: 'Flyer A4')
    products = order.products.where(name: 'Flyer A4')

    assert_equal products.count, 1
  end

  def test_that_find_by_returns_the_first_object_matching_the_criteria
    order = Keyline::Order.new
    product = order.products.build(name: 'Flyer A4')
    queried_product = order.products.find_by(name: 'Flyer A4')

    assert_equal queried_product.name, product.name
  end
end
