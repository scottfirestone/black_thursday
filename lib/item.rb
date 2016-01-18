require 'bigdecimal'
require 'sales_engine'

class Item
  attr_reader :data, :id, :name, :description, :unit_price, :merchant_id, :item_repository
  def initialize(data, item_repository)
    @data = data
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price])
    @merchant_id = data[:merchant_id].to_i
    @item_repository = item_repository
  end

  def created_at
    @created_at = Time.parse(data[:created_at]) if data[:created_at]
  end

  def updated_at
    @updated_at = Time.parse(data[:updated_at]) if data[:updated_at]
  end

  def merchant
    item_repository.find_merchant_by_merchant_id(merchant_id)
  end

  def unit_price_to_dollars
    (unit_price / 100).to_f
  end
end
