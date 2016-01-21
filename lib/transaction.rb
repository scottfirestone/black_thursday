require 'bigdecimal'
require 'sales_engine'

class Transaction
  attr_reader :data, :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :transaction_repository

  def initialize(data, transaction_repository)
    @data                        = data
    @id                          = data[:id].to_i
    @invoice_id                  = data[:invoice_id].to_i
    @credit_card_number          = data[:credit_card_number].to_i
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result                      = data[:result]
    @transaction_repository      = transaction_repository
  end

  def created_at
    @created_at = Time.parse(data[:created_at]) if  data[:created_at]
  end

  def updated_at
    @updated_at = Time.parse(data[:updated_at]) if data[:updated_at]
  end

  def invoice
    transaction_repository.find_invoice_by_invoice_id(invoice_id)
  end
end
