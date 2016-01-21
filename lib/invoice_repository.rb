require_relative 'invoice'
require 'csv'

class InvoiceRepository
  attr_reader :invoices, :sales_engine

  def initialize(invoices_csv, sales_engine)
    @invoices ||= load_data(invoices_csv)
    @sales_engine = sales_engine
  end

  def load_data(invoices)
    csv = CSV.open(invoices, headers: true, header_converters: :symbol)
    @invoices = csv.map do |row|
      Invoice.new({ :id          => row[:id],
                    :customer_id => row[:customer_id],
                    :merchant_id => row[:merchant_id],
                    :status      => row[:status],
                    :created_at  => row[:created_at],
                    :updated_at  => row[:updated_at]},
                    self)

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

  def find_merchant_by_merchant_id(merchant_id)
    sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    sales_engine.find_invoice_items_by_invoice_id(invoice_id)
  end

  def find_item_by_item_id(item_id)
    sales_engine.find_item_by_item_id(item_id)
  end

  def find_all_transactions_by_invoice_id(invoice_id)
    sales_engine.find_all_transactions_by_invoice_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    sales_engine.find_customer_by_customer_id(customer_id)
  end

  def find_all_invoices_by_date(date)
    invoices.select do |invoice|
      invoice.created_at == date
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
