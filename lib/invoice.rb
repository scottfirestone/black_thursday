require_relative 'sales_engine'

class Invoice
  attr_reader :data, :id, :customer_id, :merchant_id, :status, :invoice_repository

  def initialize(data, invoice_repository)
    @data               = data
    @id                 = data[:id].to_i
    @customer_id        = data[:customer_id].to_i
    @merchant_id        = data[:merchant_id].to_i
    @status             = data[:status].to_sym
    @invoice_repository = invoice_repository
  end

  def created_at
    Time.parse(data[:created_at]) if data[:created_at]
  end

  def updated_at
    Time.parse(data[:updated_at]) if data[:updated_at]
  end

  def merchant
    # merch_repo = SalesEngine.merchants
    invoice_repository.find_merchant_by_merchant_id(merchant_id)
    # merch_repo.find_by_id(merchant_id)
  end

  def items
    invoice_items = invoice_repository.find_invoice_items_by_invoice_id(id)

    item_id_array = invoice_items.map(&:item_id)

    item_id_array.map do |item_id|
      invoice_repository.find_items_by_item_id(item_id)
    end

  end

  def transactions
    invoice_repository.find_all_transactions_by_invoice_id(id)
  end

  def customer
    invoice_repository.find_customer_by_customer_id(customer_id)
  end

  def is_paid_in_full?
    transactions = invoice_repository.find_all_transactions_by_invoice_id(id)
    transactions.all? do |transaction|
      transaction.result == "success"
    end
  end
end
