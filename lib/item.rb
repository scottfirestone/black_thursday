require 'bigdecimal'
require 'sales_engine'

class Item
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def id
    data[:id].to_i
  end

  def name
    data[:name]
  end

  def description
    data[:description]
  end

  def unit_price
    price = data[:unit_price]
    BigDecimal.new(price, price.size)
  end

  def merchant_id
    data[:merchant_id].to_i
  end

  def created_at
    created = data[:created_at]
    unless created == nil
      Time.new(created)
    end
  end

  def updated_at
    updated = data[:updated_at]
    unless updated == nil
      Time.new(data[:updated_at])
    end
  end

  def merchant
    mr = SalesEngine.merchants
    mr.find_by_id(merchant_id)
  end
end
