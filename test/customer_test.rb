require 'test_helper'
require 'customer'

class CustomerTest < Minitest::Test
  attr_reader :customer_data, :customer_repository

  def setup

    @customer_data = {
      :id         => "1",
      :first_name => "Joey",
      :last_name  => "Ondricka",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
    }
    @customer_repository = mock()
  end

  def test_it_is_a_customer_object
    customer = Customer.new(customer_data, customer_repository)
    assert customer
  end

  def test_it_has_an_id
    customer = Customer.new(customer_data, customer_repository)
    assert_equal 1, customer.id
  end

  def test_it_has_a_first_name
    customer = Customer.new(customer_data, customer_repository)
    assert_equal "Joey", customer.first_name
  end

  def test_it_has_a_last_name
    customer = Customer.new(customer_data, customer_repository)
    assert_equal "Ondricka", customer.last_name
  end

  def test_it_has_a_created_at_date
    customer = Customer.new(customer_data, customer_repository)
    expected = Time.parse("2012-03-27 14:54:09 UTC")
    assert_equal expected, customer.created_at
  end

  def test_created_at_handles_nil
    customer = Customer.new(customer_data, customer_repository)
    customer.data[:created_at] = nil
    assert_equal nil, customer.created_at
  end

  def test_updated_at
    customer = Customer.new(customer_data, customer_repository)
    expected = Time.parse("2012-03-27 14:54:09 UTC")
    assert_equal expected, customer.updated_at
  end

  def test_updated_at_handles_nil
    customer = Customer.new(customer_data, customer_repository)
    customer.data[:updated_at] = nil
    assert_equal nil, customer.updated_at
  end
end
