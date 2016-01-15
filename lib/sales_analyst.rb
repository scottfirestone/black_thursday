require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :merch_repo, :item_repo

  def initialize(sales_engine)
    @merch_repo = sales_engine.merchants
    @item_repo = sales_engine.items
  end

  ##rename to item_counts
  def average_items_per_merchant
    items_count = merch_repo.all.map{|m|m.item_count}
    mean(items_count).round(2)

  end

  def average_items_per_merchant_standard_deviation
    items_count = merch_repo.all.map{|m|m.item_count}
    standard_deviation(items_count).round(2)
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
    merchant.average_item_price
  end

  def average_price_per_merchant
    average_merchants_price = merch_repo.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    mean(average_merchants_price).round(2)
  end

  def golden_items
  end

  def variance(array)
    return if array.length < 1
    precalculated_mean = mean(array)
    sum = array.inject(0) do |accumulator, value|
      accumulator + (value - precalculated_mean) ** 2
    end
    sum / (array.length.to_f - 1)
  end

  def standard_deviation(array)
    return if array.length < 2
    Math.sqrt(variance(array))
  end

  def mean(array)
    return if array.length < 1
    array.inject(0, :+) / array.length.to_f
  end

end
