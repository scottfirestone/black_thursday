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
      Item.new(row[:id], row[:name], row[:description], row[:unit_price],
        row[:created_at], row[:updated_at])
    end
  end

  def all
    items
  end

  def find_by_id(id)
    items.detect do |object|
      object.id == id
    end
  end

  def find_by_name(name)
    items.detect do |object|
      object.name.downcase == name.downcase
    end
  end

    #revisit and figure out cases line "the", "and", "a" etc.
  def find_all_with_description(description)
    items.select do |object|
      object.descripion.downcase.include?(description.downcase)
    end
  end
  #also, use the word 'zipper' for description test
end
