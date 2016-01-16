require_relative 'invoice'
require 'csv'

class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices_csv)
    @invoices ||= load_data(invoices_csv)
  end

  def load_data(invoices)
    csv = CSV.open(invoices, headers: true, header_converters: :symbol)
    @invoices = csv.map do |row|
      Invoice.new({:id          => row[:id],
                :customer_id => row[:customer_id],
                :merchant_id => row[:merchant_id],
                :status      => row[:status],
                :created_at  => row[:created_at],
                :updated_at  => row[:updated_at]})
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    invoices.detect do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    invoices.select do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    invoices.select do |invoice|
      invoice.status == status
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
