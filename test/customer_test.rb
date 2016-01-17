require 'test_helper'
require 'customer'

class CustomerTest < Minitest::Test
  attr_reader :customer_data

  def setup

    @customer_data = {
      :id         => "1",
      :first_name => "Joey",
      :last_name  => "Ondricka",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
    }
  end

  def test_it_is_a_customer_object
    customer = Customer.new(customer_data)
    assert customer
  end

  def test_it_has_an_id
    customer = Customer.new(customer_data)
    assert_equal 1, customer.id
  end

  def test_it_has_a_first_name
    customer = Customer.new(customer_data)
    assert_equal "Joey", customer.first_name
  end

  def test_it_has_a_last_name
    customer = Customer.new(customer_data)
    assert_equal "Ondricka", customer.last_name
  end

  def test_it_has_a_created_at_date
    customer = Customer.new(customer_data)
    expected = Time.parse("2012-03-27 14:54:09 UTC")
    assert_equal expected, customer.created_at
  end

  def test_created_at_handles_nil
    customer = Customer.new(customer_data)
    customer.data[:created_at] = nil
    assert_equal nil, customer.created_at
  end

  def test_updated_at
    customer = Customer.new(customer_data)
    expected = Time.parse("2012-03-27 14:54:09 UTC")
    assert_equal expected, customer.updated_at
  end

  def test_updated_at_handles_nil
    customer = Customer.new(customer_data)
    customer.data[:updated_at] = nil
    assert_equal nil, customer.updated_at
  end
end
