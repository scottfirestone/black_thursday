require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine

  attr_reader :merchants, :items, :invoices

  def self.from_csv(csv)
    @merchants = MerchantRepository.new(csv[:merchants])
    @items = ItemRepository.new(csv[:items])
    @invoices = InvoiceRepository.new(csv[:invoices])
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

end

if __FILE__ == $0
  puts se = SalesEngine.new.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })
  merchant = se.merchants.find_by_name("")
end
