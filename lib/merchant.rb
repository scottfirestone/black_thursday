class Merchant
  attr_reader :name, :id, :merchant_repository, :merchant_data

  def initialize(merchant_data, merchant_repository)
    @merchant_data = merchant_data
    @name = merchant_data[:name]
    @id   = merchant_data[:id].to_i
    @merchant_repository = merchant_repository
  end

  def items
    @items ||= merchant_repository.items(id)
  end

  def created_at
    @created_at = Time.parse(merchant_data[:created_at]) if merchant_data[:created_at]
  end

  def item_count
    items.count
  end

  def average_item_price
    sum_prices = (items.map { |item| item.unit_price }.reduce(0, :+) / 100)
    (sum_prices / item_count).round(2)
  end

  def invoices
    @invoices ||= merchant_repository.invoices(id)
  end

  def customers
    customer_ids = invoices.map(&:customer_id).uniq
    @customers ||= customer_ids.map do |customer_id|
      merchant_repository.find_customer_by_customer_id(customer_id)
    end
  end

  def revenue
    paid_invoices = invoices.select do |invoice|
      invoice.is_paid_in_full?
    end
    paid_invoice_items = paid_invoices.flat_map do |invoice|
      invoice.invoice_items
    end
    @revenue ||= paid_invoice_items.reduce(0) do |sum, invoice_item|
      sum + (invoice_item.quantity * invoice_item.unit_price)
    end
  end
end
