require 'minitest/autorun'
require 'adyen_hpp'
require 'string_fields_shared_tests'

class AdyenHppPaymentFieldsIssuerIdFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::IssuerIdField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'issuer_id', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'issuerId', @class.adyen_field_name
  end

  include StringFieldsSharedTests
end
