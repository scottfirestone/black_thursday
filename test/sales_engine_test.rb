require 'test_helper'
require 'sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_is_a_sales_engine_instance
    se = SalesEngine.new
    assert se
  end

  def test_it_has_a_from_csv_method
    se = SalesEngine.new
    assert_respond_to se, :from_csv
  end

  def test_the_merchants_method_returns_a_loaded_merchant_repo_object
    se = SalesEngine.new
    se.from_csv({:merchants => "test_merchants.csv"})
    mr = se.merchants
    assert_equal MerchantRepository, mr.class
  end

  def test_the_items_method_returns_a_loaded_item_repo_object
    se = SalesEngine.new
    se.from_csv({:items => "test_items.csv"})
    ir = se.items
    assert_equal ItemRepository, ir.class
  end

end
