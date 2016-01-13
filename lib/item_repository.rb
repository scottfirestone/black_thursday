require 'item'
require 'csv'

class ItemRepository
  attr_reader :items

  def initialize(items_data)
    @items = load_data(items_data)
  end

  def load_data(items)
    csv = CSV.open(items, headers: true, header_converters: :symbol)
    @items = csv.map do |row|
      Item.new({:id => row[:id], :name => row[:name],
        :description => row[:description], :unit_price => row[:unit_price],
        :merchant_id => row[:merchant_id], :created_at => row[:created_at],
        :updated_at => row[:updated_at]})
    end
  end

  def all
    items
  end

  def find_by_id(id)
    items.detect do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    items.detect do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    items.select do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    digits = price.sub(".", "").length
    bd_price = BigDecimal(price, digits)
    items.select do |item|
      item.unit_price == bd_price
    end
  end

  def find_all_by_price_in_range
  end

  def find_all_by_merchant_id(merchant_id)
    items.select do |item|
      item.merchant_id == merchant_id
    end
  end
#   find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied
  #also, use the word 'zipper' for description test
end
