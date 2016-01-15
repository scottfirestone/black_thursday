require 'test_helper'
require 'item_repository'

 class ItemRepositoryTest < Minitest::Test
   attr_reader :items_data

   def setup
     @items_data = "test_items.csv"
   end

   def test_item_repository_instance
     ir = ItemRepository.new(items_data)
     assert ir
   end

   def test_load_data_gives_array
     ir = ItemRepository.new(items_data)
     expected = Array
     actual = ir.items.class
     assert_equal expected, actual
   end

   def test_all_method_returns_array_of_item_instances
     ir = ItemRepository.new(items_data)
     actual = ir.items.sample.class
     expected = Item
     assert_equal expected, actual
   end

   ##refactor!!!!
   def test_all_method_returns_all_item_instances
     ir = ItemRepository.new(items_data)
     csv = CSV.open("test_items.csv", headers:true, header_converters: :symbol)
     count = 0
     csv.each { |line| count +=1 }

     assert_equal 159, count

     all_items = ir.all

     assert_equal 159, all_items.length
   end

   def test_find_by_id_method_returns_item_instance
     ir = ItemRepository.new(items_data)
     found_item = ir.find_by_id(263395237)

     assert_equal Item, found_item.class
     assert_equal "510+ RealPush Icon Set", found_item.name
     refute_equal "Centower", found_item.name
     assert_equal 263395237, found_item.id
     refute_equal 000000000, found_item.id
   end

   ##ask trey about refute vs assert_equal nil
   def test_find_by_id_method_returns_nil_if_no_match
     ir = ItemRepository.new(items_data)
     assert_equal nil, ir.find_by_id(001)
   end

   def test_find_by_name_method_returns_item_instance
     ir = ItemRepository.new(items_data)
     found_item = ir.find_by_name("510+ RealPush Icon Set")

     assert_equal Item, found_item.class
     assert_equal "510+ RealPush Icon Set", found_item.name

     found_item_lc = ir.find_by_name("510+ realpush icon set")
     assert_equal "510+ RealPush Icon Set", found_item_lc.name

     refute_equal "Centower", found_item.name
     assert_equal 263395237, found_item.id
     refute_equal 12345678, found_item.id
   end

   def test_find_by_name_method_returns_nil_if_no_match
     ir = ItemRepository.new(items_data)
     assert_equal nil, ir.find_by_name("Centower")
   end

   def test_find_all_by_description_method_returns_all_matching_instances
     ir = ItemRepository.new(items_data)
     found_name_array = ir.find_all_with_description("zipper").map { |item| item.name }

     assert found_name_array.include?("Overnighter in Black & Gold")
     assert found_name_array.include?("Vogue Paris Original Givenchy 2307")
     refute found_name_array.include?("Centower")
   end

   def test_find_all_by_merchant_id_method_returns_all_matching_item_instances
     ir = ItemRepository.new(items_data)
     found_merchant_id_array = ir.find_all_by_merchant_id(12334185).map { |item| item.merchant_id }

     assert_equal 3, found_merchant_id_array.size

     merchant_ids_match = found_merchant_id_array.all? { |id| id == 12334185 }
     assert merchant_ids_match
   end

   def test_find_all_by_price_method_returns_all_matching_item_instances
     ir = ItemRepository.new(items_data)
     found_price_array = ir.find_all_by_price(23.90).map { |item| item.unit_price }

     assert_equal 3, found_price_array.size
     unit_price_match = found_price_array.all? { |price| price == 23.90 }
     assert unit_price_match
   end

   def test_find_all_by_price_in_range
     ir = ItemRepository.new(items_data)
     found_price_array = ir.find_all_by_price_in_range(23.89..23.91).map { |item| item.unit_price }
     assert_equal 3, found_price_array.size

     found_price_array = ir.find_all_by_price_in_range(23.89..300.00).map { |item| item.unit_price }
     assert_equal 87, found_price_array.size

     found_price_array = ir.find_all_by_price_in_range(0..0.09)
     assert_equal [], found_price_array
   end
 end
