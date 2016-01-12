require 'item'
require 'csv'

class ItemRepository
  attr_reader :contents

  def initialize
    @contents = []
  end

  def load_data(items)
    csv = CSV.open(items, headers: true, header_converters: :symbol)
    @contents = csv.map do |row|
      Item.new(row[:id], row[:name], row[:description], row[:unit_price],
        row[:created_at], row[:updated_at])
    end
  end

  def all
    contents
  end

  def find_by_id(id)
    contents.detect do |object|
      object.id == id
    end
  end

  def find_by_name(name)
    contents.detect do |object|
      object.name.downcase == name.downcase
    end
  end

    #revisit and figure out cases line "the", "and", "a" etc.
  # def find_all_with_description(description)
  #     contents.select do |object|
  #       object.name.downcase.include?(description.downcase.split)
  #   end
  # end
  #also, use the word 'zipper' for description test
end
