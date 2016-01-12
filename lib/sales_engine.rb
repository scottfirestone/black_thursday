class SalesEngine

  def initialize
    @merchant_repository = MerchantRespository.new
    @item_repository = ItemRepository.new
  end
end
