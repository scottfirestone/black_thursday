require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions, :sales_engine

  def initialize(transaction_csv, sales_engine)
    @transactions ||= load_data(transaction_csv)
    @sales_engine   = sales_engine
  end

  def load_data(transactions)
    csv = CSV.open(transactions, headers: true, header_converters: :symbol)
    @transactions = csv.map do |row|
      Transaction.new({:id                          => row[:id],
                       :invoice_id                  => row[:invoice_id],
                       :credit_card_number          => row[:credit_card_number],
                       :credit_card_expiration_date => row[:credit_card_expiration_date],
                       :result                      => row[:result],
                       :created_at                  => row[:created_at],
                       :updated_at                  => row[:updated_at]},
                       self)
    end
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.detect do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.select do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.select do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    transactions.select do |transaction|
      transaction.result == result
    end
  end

  def find_invoice_by_invoice_id(invoice_id)
    sales_engine.find_invoice_by_invoice_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
