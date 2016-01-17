require 'test_helper'
require 'transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_is_an_transaction_repo_instance
    trans_repo = TransactionRepository.new("test_transactions.csv")
    assert_equal TransactionRepository, trans_repo.class
  end

  def test_all_returns_an_array_transaction_instances
    trans_repo = TransactionRepository.new("test_transactions.csv")
    actual = trans_repo.all.sample.class
    assert_equal Transaction, actual
  end

  def test_all_method_returns_all_transaction_instances
    trans_repo = TransactionRepository.new("test_transactions.csv")
    csv = CSV.open("test_transactions.csv", headers:true, header_converters: :symbol)
    count = 0
    csv.each { |line| count +=1 }

    assert_equal 100, count

    all_transactions = trans_repo.all

    assert_equal 100, all_transactions.length
  end

  def test_find_by_id_method_returns_transaction_instance
    trans_repo = TransactionRepository.new("test_transactions.csv")
    found_transaction = trans_repo.find_by_id(1)

    assert_equal Transaction, found_transaction.class
  end

  def test_find_by_id_method_returns_nil_if_no_match
    trans_repo = TransactionRepository.new("test_transactions.csv")
    assert_equal nil, trans_repo.find_by_id("Stuff")
  end

  def test_find_all_by_invoice_id_returns_array_of_matches
    trans_repo = TransactionRepository.new("test_transactions.csv")
    found_transactions_by_invoice_id = trans_repo.find_all_by_invoice_id(2179)
    assert_equal 2, found_transactions_by_invoice_id.size
    assert_equal Transaction, found_transactions_by_invoice_id.sample.class
  end

  def test_find_all_by_customer_id_method_returns_nil_if_no_match
    trans_repo = TransactionRepository.new("test_transactions.csv")
    assert_equal [], trans_repo.find_all_by_invoice_id("Centower")
  end

  def test_find_all_by_credit_card_number_method_returns_all_matching_transaction_instances
    trans_repo = TransactionRepository.new("test_transactions.csv")
    found_transactions_match_cc_number = trans_repo.find_all_by_credit_card_number(4068631943231473).map { |transaction| transaction.credit_card_number }

    assert_equal 1, found_transactions_match_cc_number.size

    cc_number_match = found_transactions_match_cc_number.all? { |cc_num| cc_num == 4068631943231473 }
    assert cc_number_match
  end

  def test_find_all_by_cc_number_returns_empty_array_if_no_match
    trans_repo = TransactionRepository.new("test_transactions.csv")
    assert_equal [], trans_repo.find_all_by_credit_card_number("Centower")
  end

  def test_find_all_by_result_returns_array_of_transactions_with_matching_status
    trans_repo = TransactionRepository.new("test_transactions.csv")
    transaction_statuses = trans_repo.find_all_by_result("success").map { |transaction| transaction.result }
    assert_equal 78, transaction_statuses.size

    result_matches = transaction_statuses.all? { |result| result == "success" }
    assert result_matches
  end

  def test_find_all_by_result_returns_an_empty_array_if_there_are_no_matches
    trans_repo = TransactionRepository.new("test_transactions.csv")
    transaction_results = trans_repo.find_all_by_result("super-success").map { |result| transaction.result }
    assert_equal [], transaction_results
  end
end
