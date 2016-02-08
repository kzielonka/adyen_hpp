require 'minitest/autorun'
require 'adyen_hpp'
require 'string_fields_shared_tests'

class AdyenHppPaymentFieldsShopperStatementFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::ShopperStatementField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'shopper_statement', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'shopperStatement', @class.adyen_field_name
  end

  def test_should_be_invalid_when_longer_then_135
    @field.set 'x'*136
    refute @field.valid?
  end

  def test_invalid_when_include_invalid_character
    @field.set '@'
    refute @field.valid?
  end

  include StringFieldsSharedTests
end
