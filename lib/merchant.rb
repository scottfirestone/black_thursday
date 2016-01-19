class Merchant
  attr_reader :name, :id, :merchant_repository

  def initialize(merchant_data, merchant_repository)
    @name = merchant_data[:name]
    @id   = merchant_data[:id].to_i
    @merchant_repository = merchant_repository
  end

  def items
    merchant_repository.items(id)
  end

  def item_count
    items.count
  end

  def average_item_price
    sum_prices = (items.map { |item| item.unit_price }.reduce(0, :+) / 100)
    (sum_prices / item_count).round(2)
  end

  def invoices
    merchant_repository.invoices(id)
  end

  def customers
    customer_ids = invoices.map(&:customer_id).uniq
    customer_ids.map do |customer_id|
      merchant_repository.find_customer_by_customer_id(customer_id)
    end
  end
end
