require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  attr_reader :data, :merchants, :items

  def from_csv(data)
    @data = data

  end

  def merchants
    merchants_data = data[:merchants]
    MerchantRepository.new(merchants_data)
  end

  def items
    items_data = data[:items]
    ItemRepository.new(items_data)
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
