require 'bigdecimal'

class Item
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def id
    data[:id]
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
    data[:merchant_id]
  end

  def created_at
    created = data[:created_at]
    unless created == nil
      Time.parse(created)
    end
  end

  def updated_at
    updated = data[:updated_at]
    unless updated == nil
      Time.parse(data[:updated_at])
    end
  end
end
