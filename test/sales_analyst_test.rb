require 'test_helper'
require 'sales_analyst'
require 'pry'
class SalesAnalystTest < Minitest::Test
  attr_reader :se, :sa

  def setup
    @se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "sa_test_merchants.csv", :invoices => "test_invoices.csv", :invoice_items => "test_invoice_items.csv", :transactions => "test_transactions.csv", :customers => "test_customers.csv"})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_is_a_sales_analyst_object
    assert_equal SalesAnalyst, sa.class
  end

  def test_the_average_items_per_merchant

    merchants_count = se.merchants.all.count
    assert_equal 6, merchants_count
    items_count = se.merchants.all.map{|m|m.item_count}.reduce(0, :+)

    assert_equal 24, items_count
    assert_equal 4.0, sa.average_items_per_merchant
  end

  def test_the_average_items_per_merchant_standard_deviation
    merchants_items = se.merchants.all.map{|m|m.item_count}
    assert_equal [1, 1, 1, 1, 17, 3], merchants_items
    assert_equal 6.42, sa.average_items_per_merchant_standard_deviation
  end

  def test_the_merchants_with_high_item_count
    merchants_items = se.merchants.all.map { |m| m.item_count }
    assert_equal [1, 1, 1, 1, 17, 3], merchants_items
    assert_equal 1, sa.merchants_with_high_item_count.length
    assert_equal [17], sa.merchants_with_high_item_count.map { |m| m.item_count}
  end

  def test_the_average_item_price_for_merchant
    merchant_id = 12334123
    merchant = se.merchants.find_by_id(merchant_id)
    expected = [10000, 7500, 15000, 15000, 7500, 7500, 7500, 10000, 10000, 15000, 7500, 5000, 10000, 15000, 15000, 7500, 7500]
    assert expected, merchant.items.map { |item| item.unit_price }

    assert 10147.06, sa.average_item_price_for_merchant(merchant_id)
  end

  def test_the_average_price_per_merchant

    expected = [29.99, 15.00, 150.00, 20.00, 101.47, 35.00]
    actual = sa.merch_repo.all.map do |merchant|
      merchant.average_item_price
    end

    assert_equal expected, actual
    assert 5857.68, sa.average_average_price_per_merchant
  end

  def test_golden_items
    sa = SalesAnalyst.new(se)
    our_info = sa.item_repo.all.map do |item|
      item.unit_price
    end
    assert_equal 1, sa.golden_items.count
  end

  def test_average_invoices_per_merchant
    merchants_count = se.merchants.all.count
    assert_equal 6, merchants_count
    invoices_count = se.merchants.all.map{|m|m.invoices.count}.reduce(0, :+)

    assert_equal 3, invoices_count
    assert_equal 0.5, sa.average_invoices_per_merchant
  end

  def test_the_average_invoices_per_merchant_standard_deviation
    merchants_invoices = se.merchants.all.map{ |m| m.invoices.count}
    assert_equal [0, 0, 0, 0, 3, 0], merchants_invoices
    assert_equal 1.22, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    merchants_invoices = se.merchants.all.map { |m| m.invoices.count }
    assert_equal [0, 0, 0, 0, 3, 0], merchants_invoices
    assert_equal 1, sa.top_merchants_by_invoice_count.length
    assert_equal [3], sa.top_merchants_by_invoice_count.map { |m| m.invoices.count}
  end

  def test_bottom_merchants_by_invoice_count
    merchants_invoices = se.merchants.all.map { |m| m.invoices.count }
    assert_equal [0, 0, 0, 0, 3, 0], merchants_invoices
    assert_equal 0, sa.bottom_merchants_by_invoice_count.length
    assert_equal [], sa.bottom_merchants_by_invoice_count.map { |m| m.invoices.count }
  end

  def test_top_days_by_invoice_count
    invoice_days = sa.invoice_repo.all.map { |invoice| invoice.created_at.strftime("%A")}
    expected = ["Saturday", "Friday", "Wednesday", "Monday", "Saturday", "Friday", "Monday", "Friday", "Friday", "Sunday", "Tuesday", "Monday", "Monday", "Wednesday", "Friday"]
    assert_equal expected, invoice_days

    assert_equal ["Friday"], sa.top_days_by_invoice_count
  end

  def test_invoice_status_returns_percentage_with_matching_status
    assert_equal 40, sa.invoice_status(:shipped)
    assert_equal 53.33, sa.invoice_status(:pending)
    assert_equal 6.67, sa.invoice_status(:returned)
  end

  def test_find_top_x_performing_merchants_in_terms_of_revenue
    assert_equal Array, sa.top_revenue_earners(3).class
    assert_equal Merchant, sa.top_revenue_earners(3).sample.class
    assert_equal 3, sa.top_revenue_earners(3).size
  end

  def test_merchants_with_pending_invoices
    se = SalesEngine.from_csv({:items => "test_items.csv", :merchants => "test_merchants.csv", :invoices => "test_invoices.csv", :invoice_items => "test_invoice_items.csv", :transactions => "test_transactions.csv", :customers => "test_customers.csv"})

    sa = SalesAnalyst.new(se)
    expected = sa.merchants_with_pending_invoices - [nil]
    assert_equal Merchant, expected.sample.class
    assert_equal 6, expected.length
  end

  def test_merchants_with_only_one_item
    assert_equal Merchant, sa.merchants_with_only_one_item.sample.class
    assert_equal 4, sa.merchants_with_only_one_item.length
  end

  def test_merchants_with_only_one_item_registered_in_month
    assert_equal Merchant, sa.merchants_with_only_one_item_registered_in_month("January").sample.class
    assert_equal 4, sa.merchants_with_only_one_item_registered_in_month("January").length
  end
end
