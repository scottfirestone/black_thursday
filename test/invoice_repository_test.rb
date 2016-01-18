require 'test_helper'
require 'invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine = mock()
  end

  def test_it_is_an_invoice_repo_instance
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    assert_equal InvoiceRepository, inv_repo.class
  end

  def test_all_returns_an_array_of_all_known_invoice_instances
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    actual = inv_repo.all.sample.class
    expected = Invoice
    assert_equal expected, actual
  end

  def test_all_method_returns_all_invoice_instances
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    csv = CSV.open("test_invoices.csv", headers:true, header_converters: :symbol)
    count = 0
    csv.each { |line| count +=1 }

    assert_equal 15, count

    all_invoices = inv_repo.all

    assert_equal 15, all_invoices.length
  end

  def test_find_by_id_method_returns_invoice_instance
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    found_invoice = inv_repo.find_by_id(1)

    assert_equal Invoice, found_invoice.class
  end

  def test_find_by_id_method_returns_nil_if_no_match
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    assert_equal nil, inv_repo.find_by_id("1")
  end

  def test_find_all_by_customer_id_returns_array_of_matches
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    found_invoices_by_id = inv_repo.find_all_by_customer_id(1)
    assert_equal 8, found_invoices_by_id.size
    assert_equal Invoice, found_invoices_by_id.sample.class
  end

  def test_find_all_by_customer_id_method_returns_nil_if_no_match
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    assert_equal [], inv_repo.find_all_by_customer_id("Centower")
  end

  def test_find_all_by_merchant_id_method_returns_all_matching_invoice_instances
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    found_invoices_match_merchant_id = inv_repo.find_all_by_merchant_id(12335938).map { |invoice| invoice.merchant_id }

    assert_equal 3, found_invoices_match_merchant_id.size

    merchant_ids_match = found_invoices_match_merchant_id.all? { |m_id| m_id == 12335938 }
    assert merchant_ids_match
  end

  def test_find_all_by_price_method_returns_empty_array_if_no_match
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    assert_equal [], inv_repo.find_all_by_merchant_id("Centower")
  end

  def test_find_all_by_status_returns_array_of_invoices_with_matching_status
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    invoice_statuses = inv_repo.find_all_by_status(:shipped).map { |invoice| invoice.status }
    assert_equal 6, invoice_statuses.size

    status_matches = invoice_statuses.all? { |status| status == :shipped }
    assert status_matches
  end

  def test_find_all_by_status_returns_an_empty_array_if_there_are_no_matches
    inv_repo = InvoiceRepository.new("test_invoices.csv", sales_engine)
    invoice_statuses = inv_repo.find_all_by_status("jones").map { |invoice| invoice.status }
    assert_equal [], invoice_statuses
  end
end
