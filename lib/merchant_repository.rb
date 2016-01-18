require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants, :sales_engine

  def initialize(merchants_data, sales_engine)
    @merchants ||= load_data(merchants_data)
    @sales_engine = sales_engine
  end

  def load_data(merchants)
    csv = CSV.open(merchants, headers: true, header_converters: :symbol)
    @merchants = csv.map do |row|
      Merchant.new({:name => row[:name], :id => row[:id]}, self)
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.detect do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.detect do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(search_name)
    merchants.select do |merchant|
      merchant.name.downcase.include?(search_name.downcase)
    end
  end

  def items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def invoices(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def find_customer_by_customer_id(customer_id)
    sales_engine.find_customer_by_customer_id(customer_id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
