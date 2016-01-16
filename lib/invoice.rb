class Invoice
  attr_reader :data, :id, :customer_id, :merchant_id, :status

  def initialize(data)
    @data = data
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
  end

  def created_at
    Time.parse(data[:created_at]) if data[:created_at]
  end

  def updated_at
    Time.parse(data[:updated_at]) if data[:updated_at]
  end

  def merchant
    merch_repo = SalesEngine.merchants
    merch_repo.find_by_id(merchant_id)
  end
end
