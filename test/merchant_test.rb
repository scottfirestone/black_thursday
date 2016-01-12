require 'test_helper'
require 'merchant'

 class MerchantTest < Minitest::Test
   def test_it_is_a_merchant_object
     merchant = Merchant.new
     assert merchant
   end

   #merchant args hash - needs fixing
   def test_it_has_a_name
     merchant = Merchant.new({:name => "Turing School"})
     assert_equal "Turing School", merchant.name[:name]
   end

  #  def test_it_has_an_id
  #    merchant = Merchant.new({:name => "Turing School", :id => "12345678"})
  #    assert_equal "12345678", merchant.id[:id]
  #  end
 end
