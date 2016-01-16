require 'test_helper'
require 'sales_analyst'
require 'pry'
class SalesAnalystTest < Minitest::Test
  attr_reader :se, :mr_sample

  def setup
    @se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "test_merchants.csv", :invoices => "test_invoices.csv"})
  end

  def test_it_is_a_sales_analyst_object
    sa = SalesAnalyst.new(se)
    assert_equal SalesAnalyst, sa.class
  end

  def test_the_average_items_per_merchant
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)

    merchants_count = se.merchants.all.count
    assert_equal 6, merchants_count
    items_count = se.merchants.all.map{|m|m.item_count}.reduce(0, :+)

    assert_equal 24, items_count
    assert_equal 4.0, sa.average_items_per_merchant
  end

  def test_the_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)
    merchants_items = se.merchants.all.map{|m|m.item_count}
    assert_equal [1, 1, 1, 1, 17, 3], merchants_items
    assert_equal 6.42, sa.average_items_per_merchant_standard_deviation
  end

  def test_the_merchants_with_high_item_count
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)
    merchants_items = se.merchants.all.map { |m| m.item_count }
    assert_equal [1, 1, 1, 1, 17, 3], merchants_items
    assert_equal 1, sa.merchants_with_high_item_count.length
    assert_equal [17], sa.merchants_with_high_item_count.map { |m| m.item_count}
  end

  def test_the_average_item_price_for_merchant
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)
    merchant_id = 12334123
    merchant = se.merchants.find_by_id(merchant_id)
    expected = [10000, 7500, 15000, 15000, 7500, 7500, 7500, 10000, 10000, 15000, 7500, 5000, 10000, 15000, 15000, 7500, 7500]
    assert expected, merchant.items.map { |item| item.unit_price }

    assert 10147.06, sa.average_item_price_for_merchant(merchant_id)
  end

  def test_the_average_price_per_merchant
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)

    expected = [29.99, 15.00, 150.00, 20.00, 101.47, 35.00]
    actual = sa.merch_repo.all.map do |merchant|
      merchant.average_item_price
    end

    assert_equal expected, actual
    assert 5857.68, sa.average_average_price_per_merchant
  end

  def test_golden_items
    se = SalesEngine.from_csv({:items => "sa_test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)
    our_info = sa.item_repo.all.map do |item|
      item.unit_price
    end
    assert_equal [], sa.golden_items
  end

  def test_average_invoices_per_merchant
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)

    merchants_count = se.merchants.all.count
    assert_equal 6, merchants_count
    invoices_count = se.merchants.all.map{|m|m.invoices.count}.reduce(0, :+)

    assert_equal 3, invoices_count
    assert_equal 0.5, sa.average_invoices_per_merchant
  end

  def test_the_average_invoices_per_merchant_standard_deviation
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)
    merchants_invoices = se.merchants.all.map{ |m| m.invoices.count}
    assert_equal [0, 0, 0, 0, 3, 0], merchants_invoices
    assert_equal 1.22, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)
    merchants_invoices = se.merchants.all.map { |m| m.invoices.count }
    assert_equal [0, 0, 0, 0, 3, 0], merchants_invoices
    assert_equal 1, sa.top_merchants_by_invoice_count.length
    assert_equal [3], sa.top_merchants_by_invoice_count.map { |m| m.invoices.count}
  end

  def test_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)
    merchants_invoices = se.merchants.all.map { |m| m.invoices.count }
    assert_equal [0, 0, 0, 0, 3, 0], merchants_invoices
    assert_equal 0, sa.bottom_merchants_by_invoice_count.length
    assert_equal [], sa.bottom_merchants_by_invoice_count.map { |m| m.invoices.count }
  end

  def test_top_days_by_invoice_count
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)
    ##beef up this test, intermediate assertions to clarify
    assert_equal [:Friday], sa.top_days_by_invoice_count
  end

  def test_invoice_status_returns_percentage_with_matching_status
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv"})
    sa = SalesAnalyst.new(se)
    assert_equal 40, sa.invoice_status(:shipped)
    assert_equal 53.33, sa.invoice_status(:pending)
    assert_equal 6.67, sa.invoice_status(:returned)
  end
end
