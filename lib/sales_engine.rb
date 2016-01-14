require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  attr_reader :data, :merchants, :items

  def self.from_csv(data)
    @merchants = MerchantRepository.new(data[:merchants])
    @items = ItemRepository.new(data[:items])
    self
  end

  def self.merchants
    @merchants
  end

  def self.items
    @items
  end

end

if __FILE__ == $0
  puts se = SalesEngine.new.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })

  mr = se.merchants
  merchant = mr.find_by_name("")
end
