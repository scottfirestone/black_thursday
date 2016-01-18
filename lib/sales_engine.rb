require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine

  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions, :customers

  def self.from_csv(csv)
    @merchants      = MerchantRepository.new(csv[:merchants], self)
    @items          = ItemRepository.new(csv[:items], self)
    @invoices       = InvoiceRepository.new(csv[:invoices], self)
    @invoice_items  = InvoiceItemRepository.new(csv[:invoice_items])
    @transactions   = TransactionRepository.new(csv[:transactions], self)
    @customers      = CustomerRepository.new(csv[:customers], self)
    self
  end

  def self.merchants
    @merchants
  end

  def self.items
    @items
  end

  def self.invoices
    @invoices
  end

  def self.invoice_items
    @invoice_items
  end

  def self.transactions
    @transactions
  end

  def self.customers
    @customers
  end

  def self.find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def self.find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def self.find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def self.find_invoice_items_by_invoice_id(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def self.find_items_by_item_id(item_id)
    items.find_by_id(item_id)
  end

  def self.find_all_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def self.find_customer_by_customer_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def self.find_invoice_by_invoice_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def self.find_all_invoices_by_customer_id(customer_id)
    invoices.find_all_by_customer_id(customer_id)
  end
end

if __FILE__ == $0
  puts se = SalesEngine.new.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })
  merchant = se.merchants.find_by_name("")
end
