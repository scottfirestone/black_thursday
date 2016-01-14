require 'sales_engine'

class Merchant
  attr_reader :name, :id

  def initialize(merchant_data)
    @name = merchant_data[:name]
    @id   = merchant_data[:id].to_i
  end

  def items
    ir = SalesEngine.items
    ir.find_all_by_merchant_id(id)
  end

  def item_count
    items.count
  end
end
