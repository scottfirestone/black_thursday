class Invoice
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def id
    data[:id].to_i
  end

  def customer_id
    data[:customer_id].to_i
  end

  def merchant_id
    data[:merchant_id].to_i
  end

  def status
    data[:status].to_sym
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
