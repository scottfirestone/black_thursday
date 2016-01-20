require 'test_helper'
require 'invoice_item_repository'

 class InvoiceItemRepositoryTest < Minitest::Test
   attr_reader :invoice_items_data

   def setup
     @invoice_items_data = "test_invoice_items.csv"
   end

   def test_invoice_item_repository_instance
     inv_item_repo = InvoiceItemRepository.new(invoice_items_data)
     assert inv_item_repo
   end

   def test_load_data_gives_array
     inv_item_repo = InvoiceItemRepository.new(invoice_items_data)
     expected = Array
     actual = inv_item_repo.invoice_items.class
     assert_equal expected, actual
   end

   def test_all_method_returns_array_of_item_instances
     inv_item_repo = InvoiceItemRepository.new(invoice_items_data)
     actual = inv_item_repo.all.sample.class
     expected = InvoiceItem
     assert_equal expected, actual
   end

   def test_all_method_returns_all_item_instances
     inv_item_repo = InvoiceItemRepository.new(invoice_items_data)
     csv = CSV.open("test_invoice_items.csv", headers:true, header_converters: :symbol)
     count = 0
     csv.each { |line| count +=1 }

     assert_equal 532, count

     all_invoice_items = inv_item_repo.all

     assert_equal 532, all_invoice_items.length
   end

   def test_find_by_id_method_returns_item_instance
     inv_item_repo = InvoiceItemRepository.new(invoice_items_data)
     found_invoice_item = inv_item_repo.find_by_id(1)

     assert_equal 1, found_invoice_item.id
     assert_equal 263519844, found_invoice_item.item_id
   end

   def test_find_by_id_method_returns_nil_if_no_match
     inv_item_repo = InvoiceItemRepository.new(invoice_items_data)
     assert_equal nil, inv_item_repo.find_by_id("98xCentower")
   end

   def test_find_all_by_item_id_method_returns_all_matching_invoice_item_instances
     inv_item_repo = InvoiceItemRepository.new(invoice_items_data)
     found_item_ids = inv_item_repo.find_all_by_item_id(263519844).map { |invoice_item| invoice_item.item_id }

     assert_equal 34, found_item_ids.size

     item_ids_match = found_item_ids.all? { |id| id == 263519844 }
     assert item_ids_match
   end

   def test_find_all_by_invoice_id_method_returns_all_matching_invoice_item_instances
     inv_item_repo = InvoiceItemRepository.new(invoice_items_data)
     found_invoice_ids = inv_item_repo.find_all_by_invoice_id(1).map { |invoice_item| invoice_item.invoice_id }

     assert_equal 8, found_invoice_ids.size

     invoice_ids_match = found_invoice_ids.all? { |id| id == 1 }
     assert invoice_ids_match
   end
 end
