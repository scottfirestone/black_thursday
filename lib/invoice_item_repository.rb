require_relative 'invoice_item'
require 'csv'

class InvoiceItemRepository
  attr_reader :invoice_items #, :sales_engine

  def initialize(invoice_items_csv) #, sales_engine)
    @invoice_items ||= load_data(invoice_items_csv)
    # @sales_engine = sales_engine
  end

  def load_data(invoice_items)
    csv = CSV.open(invoice_items, headers: true, header_converters: :symbol)
    @invoice_items = csv.map do |row|
      InvoiceItem.new({ :id         => row[:id],
                    :item_id    => row[:item_id],
                    :invoice_id => row[:invoice_id],
                    :quantity   => row[:quantity],
                    :unit_price => row[:unit_price],
                    :created_at => row[:created_at],
                    :updated_at => row[:updated_at]})
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    invoice_items.detect do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    invoice_items.select do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.select do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_all_by_date(date)
    invoice_items.select do |invoice_item|
      invoice_item.created_at == Time.parse(date)
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
