class Merchant
  attr_accessor :id, :name

  def initialize(name = nil, id = nil)
    @name = name
    @id = id
  end
end
