class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at

  def initialize(id = nil, name = nil, description = nil,
      unit_price = nil, created_at = nil, updated_at = nil)
    @id = id
    @name = name
    @description = description
    @unit_price = unit_price
    @created_at = created_at
    @updated_at = updated_at
  end

end
