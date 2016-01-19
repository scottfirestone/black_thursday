require 'test_helper'
require 'sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({:merchants => "test_merchants.csv", :items => "test_items.csv", :invoices => "test_invoices.csv", :invoice_items => "test_invoice_items.csv", :transactions => "test_transactions.csv", :customers => "test_customers.csv"})
  end

  def test_it_has_a_from_csv_method
    assert_respond_to SalesEngine, :from_csv
  end

  def test_the_merchants_method_returns_a_loaded_merchant_repo_object
    merch_repo = se.merchants
    assert_equal MerchantRepository, merch_repo.class
  end

  def test_the_items_method_returns_a_loaded_item_repo_object
    item_repo = se.items
    assert_equal ItemRepository, item_repo.class
  end

  def test_the_invoices_method_returns_a_loaded_invoice_repo_object
    invoice_repo = se.invoices
    assert_equal InvoiceRepository, invoice_repo.class
  end

  def test_the_invoice_items_method_returns_a_loaded_invoice_item_repo_object
    inv_item_repo = se.invoice_items
    assert_equal InvoiceItemRepository, inv_item_repo.class
  end

  def test_the_transactions_method_returns_a_loaded_transaction_repo_object
    transaction_repo = se.transactions
    assert_equal TransactionRepository, transaction_repo.class
  end

  def test_the_customers_method_returns_a_loaded_customer_repo_object
    customer_repo = se.customers
    assert_equal CustomerRepository, customer_repo.class
  end

  def test_find_items_by_merchant_id
    actual = se.find_items_by_merchant_id(12334105)
    assert_equal Array, actual.class
    assert_equal Item, actual.sample.class
    assert_equal 1, actual.length
  end

  def test_find_invoices_by_merchant_id
    actual = se.find_invoices_by_merchant_id(12335938)
    assert_equal Array, actual.class
    assert_equal Invoice, actual.sample.class
    assert_equal 3, actual.length
  end

  def test_find_merchant_by_merchant_id
    actual = se.find_merchant_by_merchant_id(12334105)
    assert_equal Merchant, actual.class
  end

  def test_find_invoice_items_by_invoice_id
    actual = se.find_invoice_items_by_invoice_id(1)
    assert_equal Array, actual.class
    assert_equal InvoiceItem, actual.sample.class
    assert_equal 8, actual.length
  end

  def test_find_item_by_item_id
    actual = se.find_item_by_item_id(263395237)
    assert_equal Item, actual.class
  end

  def test_find_all_transactions_by_invoice_id
    actual = se.find_all_transactions_by_invoice_id(2179)
    assert_equal Array, actual.class
    assert_equal Transaction, actual.sample.class
    assert_equal 2, actual.length
  end

  def test_find_customer_by_customer_id
    actual = se.find_customer_by_customer_id(1)
    assert_equal Customer, actual.class
  end

  def test_find_invoice_by_invoice_id
    actual = se.find_invoice_by_invoice_id(1)
    assert_equal Invoice, actual.class
  end

  def test_find_all_invoices_by_customer_id
    actual = se.find_all_invoices_by_customer_id(1)
    assert_equal Array, actual.class
    assert_equal Invoice, actual.sample.class
    assert_equal 8, actual.length
  end
end
