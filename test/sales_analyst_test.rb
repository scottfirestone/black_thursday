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
    # mr_sample = se.merchants.all[0..3]
    # mr_sample_count = mr_sample.count
    # items_count = mr_sample.map do |merchant|
    #   merchant.items
    # end.flatten.count
    # average = items_count / mr_sample_count

    assert_equal 4, sa.average_items_per_merchant
  end

  def test_the_average_items_per_merchant_standard_deviation
  end

  def test_the_merchants_with_low_item_count
  end

  def test_the_average_item_price_for_merchant
  end

  def test_the_average_price_per_merchant
  end

  def golden_items
  end
end
