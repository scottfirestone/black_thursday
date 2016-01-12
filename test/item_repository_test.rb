require 'test_helper'
require 'item_repository'

 class ItemRepositoryTest < Minitest::Test

   def test_item_repository_instance
     ir = ItemRepository.new
     assert ir
   end

   def test_responds_to_load_data_method
     ir = ItemRepository.new
     assert_respond_to ir, :load_data
   end

   def test_load_data_gives_array
     ir = ItemRepository.new
     expected = Array
     actual = ir.load_data("test_items.csv").class
     assert_equal expected, actual
   end

   def test_all_method_returns_array_of_item_instances
     ir = ItemRepository.new
     item_array = ir.load_data("test_items.csv")
     actual = item_array.sample.class
     expected = Item
     assert_equal expected, actual
   end

   ##refactor!!!!
   def test_all_method_returns_all_item_instances
     ir = ItemRepository.new
     csv = CSV.open("test_items.csv", headers:true, header_converters: :symbol)
     count = 0
     csv.each { |line| count +=1 }

     assert_equal 155, count

     ir.load_data("test_items.csv")
     all_items = ir.all

     assert_equal 155, all_items.length
   end

   def test_find_by_id_method_returns_item_instance
     ir = ItemRepository.new
     ir.load_data("test_items.csv")
     found_item = ir.find_by_id("263395237")

     assert_equal Item, found_item.class
     assert_equal "510+ RealPush Icon Set", found_item.name
     refute_equal "Centower", found_item.name
     assert_equal "263395237", found_item.id
     refute_equal "000000000", found_item.id
   end

   ##ask trey about refute vs assert_equal nil
   def test_find_by_id_method_returns_nil_if_no_match
     ir = ItemRepository.new
     ir.load_data("test_items.csv")
     assert_equal nil, ir.find_by_id("001")
   end

   def test_find_by_name_method_returns_item_instance
     ir = ItemRepository.new
     ir.load_data("test_items.csv")
     found_item = ir.find_by_name("510+ RealPush Icon Set")

     assert_equal Item, found_item.class
     assert_equal "510+ RealPush Icon Set", found_item.name

     found_item_lc = ir.find_by_name("510+ realpush icon set")
     assert_equal "510+ RealPush Icon Set", found_item_lc.name

     refute_equal "Centower", found_item.name
     assert_equal "263395237", found_item.id
     refute_equal "12345678", found_item.id
   end

   def test_find_by_name_method_returns_nil_if_no_match
     ir = ItemRepository.new
     ir.load_data("test_items.csv")
     assert_equal nil, ir.find_by_name("Centower")
   end

   def test_find_all_by_description_method_returns_all_matching_instances
     skip
     ir = ItemRepository.new
     ir.load_data("test_items.csv")
     found_item_array = ir.find_all_by_name("pd").map { |object| object.name }

     assert found_item_array.include?("TheWoodchopDesign")
     assert found_item_array.include?("ShopDixieChicken")
     refute found_item_array.include?("Centower")
   end

 end
