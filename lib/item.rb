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
    price = data[:unit_price].to_s
    price = price.sub(".", "")
    BigDecimal.new(price.insert(-3, "."))
  end

  def merchant_id
    data[:merchant_id].to_i
  end

  def created_at
    Time.parse(data[:created_at]) if data[:created_at]
  end

  def updated_at
    Time.parse(data[:updated_at]) if data[:updated_at]
  end

  def merchant
    mr = SalesEngine.merchants
    mr.find_by_id(merchant_id)
  end
end
