require 'csv'
require_relative 'merchant'
require 'pry'

class MerchantRepository
  attr_reader :contents

  def initialize
    @contents = []
  end

  def load_data(merchants)
    csv = CSV.open(merchants, headers: true, header_converters: :symbol)
    @contents = csv.map do |row|
      Merchant.new(row[:name], row[:id])
    end
  end

  def all
    contents
  end

  def find_by_id(id)
    contents.detect do |object|
      object.id == id
    end
  end

  def find_by_name(name)
    contents.detect do |object|
      object.name.downcase == name.downcase
    end
  end

  def find_all_by_name(search_name)
      contents.select do |object|
        object.name.downcase.include?(search_name.downcase)
    end
  end

end
