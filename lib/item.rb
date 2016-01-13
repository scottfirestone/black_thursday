require 'bigdecimal'

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(item_data)
    @id           = item_data[:id]
    @name         = item_data[:name]
    @description  = item_data[:description]
    @unit_price   = convert_to_float(item_data[:unit_price])
    @merchant_id  = item_data[:merchant_id]
    @created_at   = Time.parse(item_data[:created_at]) unless item_data[:created_at] == nil
    @updated_at   = Time.parse(item_data[:updated_at]) unless item_data[:updated_at] == nil
  end

  def convert_to_float(unit_price)
    if unit_price
      number_of_digits = unit_price.sub(".","").size
      BigDecimal.new(unit_price,number_of_digits)
    end
  end
end
