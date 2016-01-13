require 'test_helper'
require 'item'
require 'pry'

class ItemTest < Minitest::Test
  attr_reader :item_data

  def setup
    @item_data = {
      :id => "263397163",
      :name => "A Variety of Fragrance Oils for Oil Burners, Potpourri, Resins + More, Lavender, Patchouli, Nag Champa, Rose, Vanilla, White Linen, Angel",
      :description => "A little definitely goes a long way with Bloomin Scents enticing, relaxing home and anywhere you want tranquillity fragrance oils. Uplift your senses with classic blends of Cinnamon & Orange, Apple Fresh, Patchouli, lavender and more.\r\n\r\nUse a drop of one of these fragrance oils in a burner for a roomful of scent. These oils are specifically for &#39;Oil Burners in 10ml Amber Bottles",
      :unit_price => "399",
      :merchant_id => "12334207",
      :created_at => "2016-01-11 10:51:02 UTC",
      :updated_at => "1988-09-01 17:09:25 UTC"
    }
  end

  def test_it_is_a_item_object
    item = Item.new(item_data)
    assert item
  end

  def test_it_has_an_id
    item = Item.new(item_data)
    assert_equal "263397163", item.id
  end

  def test_it_has_a_name
    item = Item.new(item_data)
    expected = "A Variety of Fragrance Oils for Oil Burners, Potpourri, Resins + More, Lavender, Patchouli, Nag Champa, Rose, Vanilla, White Linen, Angel"
    assert_equal expected, item.name
  end

  def test_it_has_a_description
    item = Item.new(item_data)
    expected = "A little definitely goes a long way with Bloomin Scents enticing, relaxing home and anywhere you want tranquillity fragrance oils. Uplift your senses with classic blends of Cinnamon & Orange, Apple Fresh, Patchouli, lavender and more.\r\n\r\nUse a drop of one of these fragrance oils in a burner for a roomful of scent. These oils are specifically for &#39;Oil Burners in 10ml Amber Bottles"
    assert_equal expected, item.description
  end

  ##check format
  def test_it_has_a_unit_price
    item = Item.new(item_data)
    expected = BigDecimal("399", 3)
    assert_equal expected, item.unit_price

    item_two = Item.new({:unit_price => "5807.00"})
    expected = BigDecimal("5807.00", 6)
    assert_equal expected, item_two.unit_price
  end

  def test_it_has_a_merchant_id
    item = Item.new(item_data)
    expected = "12334207"
    assert_equal expected, item.merchant_id
  end

  ###check format
  def test_it_has_a_created_at_date
    item = Item.new(item_data)
    expected = Time.parse("2016-01-11 10:51:02 UTC")
    assert_equal expected, item.created_at
  end

  ###check format
  def test_updated_at
    item = Item.new(item_data)
    expected = Time.parse("1988-09-01 17:09:25 UTC")
    assert_equal expected, item.updated_at
  end
end
