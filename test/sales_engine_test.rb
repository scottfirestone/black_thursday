require 'test_helper'
require 'sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_has_a_from_csv_method
    se = SalesEngine
    assert_respond_to SalesEngine, :from_csv
  end

  def test_the_merchants_method_returns_a_loaded_merchant_repo_object
    se = SalesEngine.from_csv({:merchants => "test_merchants.csv", :items => "test_items.csv", :invoices => "test_invoices.csv"})
    mr = se.merchants
    assert_equal MerchantRepository, mr.class
  end

  def test_the_items_method_returns_a_loaded_item_repo_object
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "test_merchants.csv", :invoices => "test_invoices.csv"})
    ir = se.items
    assert_equal ItemRepository, ir.class
  end

end
