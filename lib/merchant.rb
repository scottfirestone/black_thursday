class Merchant
  attr_accessor :id, :name

  def initialize(params = {})
    @name = params.fetch{:name => nil}
    @id = perams.fetch{:id => nil}
  end
end
