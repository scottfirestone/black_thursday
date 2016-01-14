require 'sales_engine'
require 'pry'
class SalesAnalyst
  attr_reader :mr, :ir

  def initialize(sales_engine)
    @mr = sales_engine.merchants
    @ir = sales_engine.items
  end

  def average_items_per_merchant
    merchants = mr.all
    merchants_count = merchants.count
    items_count = merchants.map do |merchant|
      merchant.items
    end.flatten.count
    items_count / merchants_count
    # this needs to be work on
  end

  def average_items_per_merchant_standard_deviation
  end

  def merchants_with_low_item_count
  end

  def average_item_price_for_merchant(merchant_id)
  end

  def average_price_per_merchant
  end

  def golden_items
  end
end
