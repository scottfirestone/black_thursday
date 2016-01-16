require 'test_helper'
require 'merchant'

class MerchantTest < Minitest::Test

  def test_it_is_a_merchant_object
    merchant = Merchant.new(:name => "Turing School")
    assert merchant
  end

  def test_it_has_a_name
    merchant = Merchant.new({:name => "Turing School"})
    assert_equal "Turing School", merchant.name
  end

  def test_it_has_an_id
    merchant = Merchant.new({:name => "Turing School", :id => "12345678"})
    assert_equal 12345678, merchant.id
  end

  def test_items_method_returns_all_items_matching_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./test_items.csv",
      :merchants => "./test_merchants.csv",
      :invoices => "./test_invoices.csv"
      })
    merchant = se.merchants.find_by_id(12334105)
    assert merchant.items
  end

  def test_item_count
    se = SalesEngine.from_csv({
      :items     => "./test_items.csv",
      :merchants => "./test_merchants.csv",
      :invoices => "./test_invoices.csv"
      })
    merchant = se.merchants.find_by_id(12334105)
    assert_equal 1, merchant.item_count

    big_merchant = se.merchants.find_by_id(12334123)
    assert_equal 17, big_merchant.item_count
  end

  def test_it_finds_the_average_item_price
    se = SalesEngine.from_csv({
      :items     => "./test_items.csv",
      :merchants => "./test_merchants.csv",
      :invoices => "./test_invoices.csv"
      })
    merchant = se.merchants.find_by_id(12334123)
    assert_equal 101.47, merchant.average_item_price
  end
end
