require 'test_helper'
require 'sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :se, :mr_sample

  def setup
    @se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "test_merchants.csv"})
  end

  def test_it_is_a_sales_analyst_object
    sa = SalesAnalyst.new(se)
    assert_equal SalesAnalyst, sa.class
  end
  #start fresh with this test
  def test_the_average_items_per_merchant
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv"})
    sa = SalesAnalyst.new(se)

    merchants_count = se.merchants.all.count
    assert_equal 6, merchants_count
    items_count = se.merchants.all.map{|m|m.item_count}.reduce(0, :+)

    assert_equal 24, items_count
    assert_equal 4.0, sa.average_items_per_merchant
  end

  def test_the_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv"})
    sa = SalesAnalyst.new(se)
    merchants_items = se.merchants.all.map{|m|m.item_count}
    assert_equal [1, 1, 1, 1, 17, 3], merchants_items
    assert_equal 6.42, sa.average_items_per_merchant_standard_deviation
  end

  def test_the_merchants_with_low_item_count
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv"})
    sa = SalesAnalyst.new(se)
    merchants_items = se.merchants.all.map{|m|m.item_count}
    assert_equal [1, 1, 1, 1, 17, 3], merchants_items
    assert_equal 0, sa.merchants_with_low_item_count.length
    assert_equal [], sa.merchants_with_low_item_count.map { |m| m.item_count}
  end

  def test_the_average_item_price_for_merchant
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv"})
    sa = SalesAnalyst.new(se)
    merchant_id = 12334123
    merchant = se.merchants.find_by_id(merchant_id)
    expected = [10000, 7500, 15000, 15000, 7500, 7500, 7500, 10000, 10000, 15000, 7500, 5000, 10000, 15000, 15000, 7500, 7500]
    assert expected, merchant.items.map { |item| item.unit_price }

    assert 10147.06, sa.average_item_price_for_merchant(merchant_id)
  end

  def test_the_average_price_per_merchant
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv"})
    sa = SalesAnalyst.new(se)
    
    expected = [2999, 1500, 15000, 2000, 10147.06, 3500]
    actual = sa.merch_repo.all.map do |merchant|
      merchant.average_item_price
    end

    assert_equal expected, actual
    assert 5857.68, sa.average_price_per_merchant
  end

  def golden_items
  end
end
