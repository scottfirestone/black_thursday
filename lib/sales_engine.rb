require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine

  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions, :customers

  def self.from_csv(csv)
    @merchants      = MerchantRepository.new(csv[:merchants])
    @items          = ItemRepository.new(csv[:items])
    @invoices       = InvoiceRepository.new(csv[:invoices])
    @invoice_items  = InvoiceItemRepository.new(csv[:invoice_items])
    @transactions   = TransactionRepository.new(csv[:transactions])
    @customers      = CustomerRepository.new(csv[:customers])
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
end

if __FILE__ == $0
  puts se = SalesEngine.new.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })
  merchant = se.merchants.find_by_name("")
end
