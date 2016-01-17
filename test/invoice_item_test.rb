require 'test_helper'
require 'invoice_item'

class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item_data

  def setup
    @invoice_item_data = {
      :id           => "1",
      :item_id      => "263519844",
      :invoice_id   => "1",
      :quantity     => "5",
      :unit_price   => "13635",
      :created_at   => "2012-03-27 14:54:09 UTC",
      :updated_at   => "2012-03-27 14:54:09 UTC"
    }
  end

  def test_it_is_a_invoice_object
    invoice_item = InvoiceItem.new(invoice_item_data)
    assert invoice_item
  end

  def test_it_has_an_id
    invoice_item = InvoiceItem.new(invoice_item_data)
    assert_equal 1, invoice_item.id
  end

  def test_it_has_an_item_id
    invoice_item = InvoiceItem.new(invoice_item_data)
    assert_equal 263519844, invoice_item.item_id
  end

  def test_it_has_an_invoice_id
    invoice_item = InvoiceItem.new(invoice_item_data)
    assert_equal 1, invoice_item.invoice_id
  end

  def test_it_has_a_quantity
    invoice_item = InvoiceItem.new(invoice_item_data)
    assert_equal 5, invoice_item.quantity
  end

  def test_it_has_a_unit_price
    invoice_item = InvoiceItem.new(invoice_item_data)
    assert_equal 13635, invoice_item.unit_price
  end

  def test_it_has_a_created_at_date
    invoice_item = InvoiceItem.new(invoice_item_data)
    expected = Time.parse("2012-03-27 14:54:09 UTC")
    assert_equal expected, invoice_item.created_at
  end

  def test_created_at_handles_nil
    invoice_item = InvoiceItem.new(invoice_item_data)
    invoice_item.data[:created_at] = nil
    assert_equal nil, invoice_item.created_at
  end

  def test_updated_at
    invoice_item = InvoiceItem.new(invoice_item_data)
    expected = Time.parse("2012-03-27 14:54:09 UTC")
    assert_equal expected, invoice_item.updated_at
  end

  def test_updated_at_handles_nil
    invoice_item = InvoiceItem.new(invoice_item_data)
    invoice_item.data[:updated_at] = nil
    assert_equal nil, invoice_item.updated_at
  end

  def test_unit_price_to_dollars
    invoice_item = InvoiceItem.new(invoice_item_data)
    expected = 136.35
    assert_equal expected, invoice_item.unit_price_to_dollars
  end
end
