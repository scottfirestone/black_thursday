class Merchant
  attr_reader :id, :name

  def initialize(name = nil, id = nil)
    @name = name
    @id = id
  end
end
