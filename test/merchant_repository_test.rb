require 'test_helper'
require 'merchant_repository'

 class MerchantRepositoryTest < Minitest::Test

  attr_reader :merchants_data

  def setup
    @merchants_data = "test_merchants.csv"
  end

  def test_merchant_repository_instance
    mr = MerchantRepository.new(merchants_data)
    assert mr
  end

  def test_responds_to_load_data_method
    mr = MerchantRepository.new(merchants_data)
    assert_respond_to mr, :load_data
  end

  def test_load_data_gives_array
    mr = MerchantRepository.new(merchants_data)
    expected = Array
    actual = mr.load_data("test_merchants.csv").class
    assert_equal expected, actual
  end

  def test_all_method_returns_array_of_merchant_instances
    mr = MerchantRepository.new(merchants_data)
    merchant_array = mr.load_data("test_merchants.csv")
    actual = merchant_array.sample.class
    expected = Merchant
    assert_equal expected, actual
  end

  ##refactor!!!!
  def test_all_method_returns_all_merchant_instances
    mr = MerchantRepository.new(merchants_data)
    csv = CSV.open("test_merchants.csv", headers:true, header_converters: :symbol)
    count = 0
    csv.each { |line| count +=1 }

    assert_equal 199, count

    mr.load_data("test_merchants.csv")
    all_merchants = mr.all

    assert_equal 199, all_merchants.length
  end

  def test_find_by_id_method_returns_merchant_instance
    mr = MerchantRepository.new(merchants_data)
    mr.load_data("test_merchants.csv")
    found_merchant = mr.find_by_id("12334984")

    assert_equal Merchant, found_merchant.class
    assert_equal "ShopDixieChicken", found_merchant.name
    refute_equal "Centower", found_merchant.name
    assert_equal "12334984", found_merchant.id
    refute_equal "12345678", found_merchant.id
  end

  ##ask trey about refute vs assert_equal nil
  def test_find_by_id_method_returns_nil_if_no_match
    mr = MerchantRepository.new(merchants_data)
    mr.load_data("test_merchants.csv")
    assert_equal nil, mr.find_by_id("001")
  end

  def test_find_by_name_method_returns_merchant_instance
    mr = MerchantRepository.new(merchants_data)
    mr.load_data("test_merchants.csv")
    found_merchant = mr.find_by_name("ShopDixieChicken")

    assert_equal Merchant, found_merchant.class
    assert_equal "ShopDixieChicken", found_merchant.name

    found_merchant_lc = mr.find_by_name("shopdixiechicken")
    assert_equal "ShopDixieChicken", found_merchant_lc.name

    refute_equal "Centower", found_merchant.name
    assert_equal "12334984", found_merchant.id
    refute_equal "12345678", found_merchant.id
  end

  def test_find_by_name_method_returns_nil_if_no_match
    mr = MerchantRepository.new(merchants_data)
    mr.load_data("test_merchants.csv")
    assert_equal nil, mr.find_by_name("Centower")
  end

  def test_find_all_by_name_method_returns_all_matching_instances
    mr = MerchantRepository.new(merchants_data)
    mr.load_data("test_merchants.csv")
    found_merchant_array = mr.find_all_by_name("pd").map { |object| object.name }

    assert found_merchant_array.include?("TheWoodchopDesign")
    assert found_merchant_array.include?("ShopDixieChicken")
    refute found_merchant_array.include?("Centower")
  end

end
