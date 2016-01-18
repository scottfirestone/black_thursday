require_relative 'item'
require 'csv'

class ItemRepository
  attr_reader :items, :sales_engine

  def initialize(items_csv, sales_engine)
    @items ||= load_data(items_csv)
    @sales_engine = sales_engine
  end

  def load_data(items)
    csv = CSV.open(items, headers: true, header_converters: :symbol)
    @items = csv.map do |row|
      Item.new({:id          => row[:id],
                :name        => row[:name],
                :description => row[:description],
                :unit_price  => row[:unit_price],
                :merchant_id => row[:merchant_id],
                :created_at  => row[:created_at],
                :updated_at  => row[:updated_at]},
                self)
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
    items.select do |item|
      item.unit_price_to_dollars == BigDecimal.new(price.to_s)
    end
  end

  def find_all_by_price_in_range(range)
    items.select do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.select do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_merchant_by_merchant_id(id)
    sales_engine.find_merchant_by_merchant_id(id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
