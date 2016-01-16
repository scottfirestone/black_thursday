require_relative 'sales_engine'
require 'bigdecimal'
require 'pry'
class SalesAnalyst
  attr_reader :merch_repo, :item_repo, :invoice_repo

  def initialize(sales_engine)
    @merch_repo   = sales_engine.merchants
    @item_repo    = sales_engine.items
    @invoice_repo = sales_engine.invoices
  end

  def average_items_per_merchant
    items_count = merch_repo.all.map{|m|m.item_count}
    mean(items_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_count = merch_repo.all.map { |m| m.item_count }
    standard_deviation(items_count).round(2)
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation

    merch_repo.all.select do |merchant|
      merchant.item_count > (mean + std_dev)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = merch_repo.find_by_id(merchant_id)
    merchant.average_item_price
  end

  def average_average_price_per_merchant
    average_merchants_price = merch_repo.all.map do |merchant|
      merchant.item_count == 0 ? 0 : average_item_price_for_merchant(merchant.id)
    end
    mean(average_merchants_price).round(2)
  end

  def golden_items
    item_prices = item_repo.all.map do |item|
      item.unit_price
    end
    average_item_price = item_prices.reduce(0, :+) / item_repo.all.length
    item_repo.all.select do |item|
      item.unit_price > (average_item_price + (2 * (standard_deviation(item_prices))))
    end
  end

  def average_invoices_per_merchant
    mean(invoice_counts).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_counts).round(2)
  end

  def top_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    merch_repo.all.select do |merchant|
      merchant.invoices.count > (mean + (2 * (std_dev)))
    end
  end

  def bottom_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    merch_repo.all.select do |merchant|
      merchant.invoices.count < (mean - (2 * (std_dev)))
    end
  end

  def top_days_by_invoice_count
    mean = mean(sales_per_day.values).round(2)
    std_dev = standard_deviation(sales_per_day.values).round(2)
    sales_per_day.select do |day, number|
      number > (mean + std_dev)
    end.keys
  end

  def invoice_status(status)
    matching_status_invoices = invoice_repo.all.select do |invoice|
      invoice.status == status
    end
    ((matching_status_invoices.count.to_f / invoice_repo.all.count) * 100).round(2)
  end

  private

  def invoice_counts
    merch_repo.all.map { |merchant| merchant.invoices.count }
  end

  def sales_per_day
    day_counts = Hash.new(0)
    extract_invoice_days.each do |day|
      day_counts[day.to_sym] += 1
    end
    day_counts
  end

  def extract_invoice_days
    invoice_repo.all.map do |invoice|
      invoice.created_at.strftime("%A")
    end
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
