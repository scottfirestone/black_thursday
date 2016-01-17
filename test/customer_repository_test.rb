require 'test_helper'
require 'customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customers_data

  def setup
    @customers_data = "test_customers.csv"
  end

  def test_customer_repository_instance
    cr = CustomerRepository.new(customers_data)
    assert cr
  end

  def test_load_data_gives_array
    cr = CustomerRepository.new(customers_data)
    expected = Array
    actual = cr.customers.class
    assert_equal expected, actual
  end

  def test_all_method_returns_array_of_customer_instances
    cr = CustomerRepository.new(customers_data)
    actual = cr.all.sample.class
    expected = Customer
    assert_equal expected, actual
  end

  def test_all_method_returns_all_customer_instances
    cr = CustomerRepository.new(customers_data)
    csv = CSV.open("test_customers.csv", headers:true, header_converters: :symbol)
    count = 0
    csv.each { |line| count +=1 }

    assert_equal 100, count

    all_customers = cr.all

    assert_equal 100, all_customers.length
  end

  def test_find_by_id_method_returns_customer_instance
    cr = CustomerRepository.new(customers_data)
    found_customer = cr.find_by_id(6)

    assert_equal Customer, found_customer.class
    assert_equal "Heber", found_customer.first_name
    refute_equal "Centower", found_customer.last_name
    assert_equal "Kuhn", found_customer.last_name
    refute_equal 000000000, found_customer.id
  end

  def test_find_by_id_method_returns_nil_if_no_match
    cr = CustomerRepository.new(customers_data)
    assert_equal nil, cr.find_by_id(123454)
  end

  def test_find_all_by_first_name_method_returns_all_customer_instances
    cr = CustomerRepository.new(customers_data)
    found_customers = cr.find_all_by_first_name("Heber")

    assert_equal Array, found_customers.class
    assert_equal Customer, found_customers.sample.class
    assert_equal "Heber", found_customers.sample.first_name

    found_customer_lc = cr.find_all_by_first_name("heber")
    assert_equal "Heber", found_customer_lc.sample.first_name

    refute_equal "Centower", found_customers.sample.first_name
  end

  def test_find_all_by_first_name_method_returns_empty_array_if_no_match
    cr = CustomerRepository.new(customers_data)
    assert_equal [], cr.find_all_by_first_name("Centower")
  end

  def test_find_all_by_last_name_method_returns_all_matching_instances
    cr = CustomerRepository.new(customers_data)
    found_last_names = cr.find_all_by_last_name("Kuhn").map { |customer| customer.last_name }

    assert found_last_names.include?("Kuhn")
    refute found_last_names.include?("Centower")
  end
end
