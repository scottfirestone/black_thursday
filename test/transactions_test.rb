require 'test_helper'
require 'transaction'

class TransactionTest < Minitest::Test
  attr_reader :transaction_data, :transaction_repository

  def setup
    @transaction_data = {
      :id                          => "1",
      :invoice_id                  => "2179",
      :credit_card_number          => "4068631943231473",
      :credit_card_expiration_date => "0217",
      :result                      => "success",
      :created_at                  => "2012-02-26 20:56:56 UTC",
      :updated_at                  => "2012-02-26 20:56:56 UTC"}
    @transaction_repository = mock()
  end

  def test_it_is_a_transaction_object
    transaction = Transaction.new(transaction_data, transaction_repository)
    assert transaction
  end

  def test_it_has_an_id
    transaction = Transaction.new(transaction_data, transaction_repository)
    assert_equal 1, transaction.id
  end

  def test_it_has_an_invoice_id
    transaction = Transaction.new(transaction_data, transaction_repository)
    assert_equal 2179, transaction.invoice_id
  end

  def test_it_has_a_credit_card_number
    transaction = Transaction.new(transaction_data, transaction_repository)
    assert_equal 4068631943231473, transaction.credit_card_number
  end

  def test_it_has_an_expiration_date
    transaction = Transaction.new(transaction_data, transaction_repository)
    expected = "0217"
    assert_equal expected, transaction.credit_card_expiration_date
  end

  def test_it_has_a_result
    transaction = Transaction.new(transaction_data, transaction_repository)
    expected = "success"
    assert_equal expected, transaction.result
  end

  def test_created_at
    transaction = Transaction.new(transaction_data, transaction_repository)
    expected = Time.parse("2012-02-26 20:56:56 UTC")
    assert_equal expected, transaction.created_at
  end

  def test_created_at_handles_nil
    transaction = Transaction.new(transaction_data, transaction_repository)
    transaction.data[:created_at] = nil
    assert_equal nil, transaction.created_at
  end

  def test_updated_at
    transaction = Transaction.new(transaction_data, transaction_repository)
    expected = Time.parse("2012-02-26 20:56:56 UTC")
    assert_equal expected, transaction.updated_at
  end

  def test_updated_at_handles_nil
    transaction = Transaction.new(transaction_data, transaction_repository)
    transaction.data[:updated_at] = nil
    assert_equal nil, transaction.updated_at
  end
end
