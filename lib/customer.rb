class Customer
  attr_reader :data, :id, :first_name, :last_name, :customer_repository

  def initialize(data, customer_repository)
    @data       = data
    @id         = data[:id].to_i
    @first_name = data[:first_name].capitalize
    @last_name  = data[:last_name].capitalize
    @customer_repository = customer_repository
  end

  def created_at
    Time.parse(data[:created_at]) if data[:created_at]
  end

  def updated_at
    Time.parse(data[:updated_at]) if data[:updated_at]
  end

  def merchants
    invoices = customer_repository.find_all_invoices_by_customer_id(id)
    merchant_ids = invoices.map(&:merchant_ids)
    merchant_ids.map do |merchant_id|
      customer_repository.find_merchant_by_merchant_id(merchant_id)
    end
  end
end
