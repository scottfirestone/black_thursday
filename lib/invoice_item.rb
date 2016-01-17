require 'bigdecimal'
require 'sales_engine'

class InvoiceItem
  attr_reader :data, :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(data)
    @data       = data
    @id         = data[:id].to_i
    @item_id    = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity   = data[:quantity].to_i
    @unit_price = BigDecimal.new(data[:unit_price])
  end

  def created_at
    @created_at = Time.parse(data[:created_at]) if data[:created_at]
  end

  def updated_at
    @updated_at = Time.parse(data[:updated_at]) if data[:updated_at]
  end

  def unit_price_to_dollars
    (unit_price / 100).to_f
  end
end
