require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsMerchantReferenceFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::MerchantReferenceField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'merchant_reference', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'merchantReference', @class.adyen_field_name
  end

  def test_adyen_conversion_from_string
    @field.set 'test'
    assert_equal 'test', @field.convert
  end

  def test_adyen_conversion_from_integer
    @field.set 1234
    assert_equal '1234', @field.convert
  end

  def test_adyen_conversion_from_array
    @field.set ['User', 1]
    assert_equal 'User-1', @field.convert
  end

  def test_validation_when_nil
    @field.set nil
    refute @field.valid?
  end

  def test_validation_when_too_long
    @field.set 'x' * 81
    refute @field.valid?
  end

  def test_validation_when_has_80_chars
    @field.set 'x' * 80
    assert @field.valid?
  end

  def test_validation_when_simple_text
    @field.set 'x' * 20
    assert @field.valid?
  end
end
