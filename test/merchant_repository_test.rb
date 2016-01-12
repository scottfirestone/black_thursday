require 'test_helper'
require 'merchant_repository'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  def test_merchant_instance
    mr = MerchantRepository.new
    assert mr
  end

  def test_responds_to_load_data_method
    mr = MerchantRepository.new
    assert_respond_to mr, :load_data
  end

  def test_load_data_gives_array
    mr = MerchantRepository.new
    expected = Array
    actual = mr.load_data("test_merchants.csv").class
    assert_equal expected, actual
  end

  def test_all_method_returns_array_of_merchant_instances
    mr = MerchantRepository.new
    merchant_array = mr.load_data("test_merchants.csv")
    actual = merchant_array.sample.class
    expected = Merchant
    assert_equal expected, actual
  end

  ##refactor!!!!
  def test_the_all_method_returns_all_merchant_instances
    mr = MerchantRepository.new
    csv = CSV.open("test_merchants.csv", headers:true, header_converters: :symbol)
    count = 0
    csv.each { |line| count +=1 }

    assert_equal 199, count

    mr.load_data("test_merchants.csv")
    all_merchants = mr.all

    assert_equal 199, all_merchants.length
  end

  def test_the_find_by_id_method_returns_a_merchant_object_based_on_its_id
    mr = MerchantRepository.new
    mr.load_data("test_merchants.csv")
    found_merchant = mr.find_by_id("12334984")

    assert_equal Merchant, found_merchant.class
    assert_equal "ShopDixieChicken", found_merchant.name
    refute_equal "Centower", found_merchant.name
    assert_equal "12334984", found_merchant.id
    refute_equal "12345678", found_merchant.id
  end


end
