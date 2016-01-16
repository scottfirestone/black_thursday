require 'test_helper'
require 'invoice'

class InvoiceTest < Minitest::Test
  attr_reader :invoice_data

  def setup
    @invoice_data = {
      :id           => "1",
      :customer_id  => "1",
      :status       => "pending",
      :merchant_id  => "12335938",
      :created_at   => "2009-02-07",
      :updated_at   => "2014-03-15"
    }
  end

  def test_it_is_a_invoice_object
    invoice = Invoice.new(invoice_data)
    assert invoice
  end

  def test_it_has_an_id
    invoice = Invoice.new(invoice_data)
    assert_equal 1, invoice.id
  end

  def test_it_has_a_customer_id
    invoice = Invoice.new(invoice_data)
    assert_equal 1, invoice.customer_id
  end

  def test_it_has_a_status
    invoice = Invoice.new(invoice_data)
    assert_equal :pending, invoice.status
  end

  def test_it_has_a_merchant_id
    invoice = Invoice.new(invoice_data)
    expected = 12335938
    assert_equal expected, invoice.merchant_id
  end

  def test_it_has_a_created_at_date
    invoice = Invoice.new(invoice_data)
    expected = Time.parse("2009-02-07")
    assert_equal expected, invoice.created_at
  end

  def test_created_at_handles_nil
    invoice = Invoice.new(invoice_data)
    invoice.data[:created_at] = nil
    assert_equal nil, invoice.created_at
  end

  def test_updated_at
    invoice = Invoice.new(invoice_data)
    expected = Time.parse("2014-03-15")
    assert_equal expected, invoice.updated_at
  end

  def test_updated_at_handles_nil
    invoice = Invoice.new(invoice_data)
    invoice.data[:updated_at] = nil
    assert_equal nil, invoice.updated_at
  end

  def test_merchant_method_returns_merchant_with_matching_id
    se = SalesEngine.from_csv({
      :items     => "./test_items.csv",
      :merchants => "./test_merchants.csv",
      :invoices  => "./test_invoices.csv"
      })
    invoice = se.invoices.find_by_id(175)
    assert_equal Merchant, invoice.merchant.class
  end
end
