require_relative 'sales_engine'
require 'descriptive-statistics'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :merch_repo, :item_repo

  def initialize(sales_engine)
    @merch_repo = sales_engine.merchants
    @item_repo = sales_engine.items
  end

  def average_items_per_merchant
    items_count = merch_repo.all.map{|m|m.item_count}
    stats = DescriptiveStatistics::Stats.new(items_count)
    stats.mean.round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_count = merch_repo.all.map{|m|m.item_count}
    stats = DescriptiveStatistics::Stats.new(items_count)
    stats.standard_deviation.round(2)
  end

  def merchants_with_low_item_count
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation

    merch_repo.all.select do |merchant|
      merchant.item_count < (mean - std_dev)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = merch_repo.find_by_id(merchant_id)
    item_prices = merchant.items.map do |item|
      item.unit_price
    end
    stats = DescriptiveStatistics::Stats.new(item_prices)
    stats.mean.round(2)
  end

  def average_price_per_merchant
    average_merchants_price = merch_repo.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    stats = DescriptiveStatistics::Stats.new(average_merchants_price)
    stats.mean.round(2)
  end

  def golden_items
  end
end
