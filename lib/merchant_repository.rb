require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(merchants_data)
    @merchants = load_data(merchants_data)
  end

  def load_data(merchants)
    csv = CSV.open(merchants, headers: true, header_converters: :symbol)
    @merchants = csv.map do |row|
      Merchant.new({:name => row[:name], :id => row[:id]})
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
end
