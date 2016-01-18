require_relative 'customer'
require 'csv'

class CustomerRepository
  attr_reader :customers, :sales_engine

  def initialize(customers_csv, sales_engine)
    @customers ||= load_data(customers_csv)
    @sales_engine = sales_engine
  end

  def load_data(customers)
    csv = CSV.open(customers, headers: true, header_converters: :symbol)
    @customers = csv.map do |row|
      Customer.new({:id         => row[:id],
                    :first_name => row[:first_name],
                    :last_name  => row[:last_name],
                    :created_at => row[:created_at],
                    :updated_at => row[:updated_at]},
                    self)
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    customers.detect do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    customers.select do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    customers.select do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def find_all_invoices_by_customer_id(customer_id)
    sales_engine.find_all_invoices_by_customer_id(customer_id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
