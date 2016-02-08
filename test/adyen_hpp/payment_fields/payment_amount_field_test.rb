require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsPaymentAmountFieldTest < Minitest::Test
  def setup
    @payment_fields = MiniTest::Mock.new
    @payment_fields.expect :nil?, false
    @currency_code_field = MiniTest::Mock.new
    @class = AdyenHpp::PaymentFields::PaymentAmountField
    @field = @class.new nil, @payment_fields
  end

  def test_field_name
    assert_equal 'payment_amount', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'paymentAmount', @class.adyen_field_name
  end

  def test_raise_error_when_payment_fields_are_missing
    assert_raises AdyenHpp::PaymentFields::Base::MissingPaymentFieldsError do
      @class.new nil, nil
    end
  end

  def test_validation_missing_value
    @field.set nil
    refute @field.valid?
  end

  def test_validation_invalid_type
    @field.set Object.new
    refute @field.valid?
  end

  def test_validation_invalid_currency_code
    @payment_fields.expect :currency_code, @currency_code_field
    @payment_fields.expect :currency_code, @currency_code_field
    @currency_code_field.expect :valid?, false
    @currency_code_field.expect :adyen_field_name, 'currencyCode'
    @field.set 20
    refute @field.valid?
  end

  def test_validation_for_valid_value
    @payment_fields.expect :currency_code, @currency_code_field
    @currency_code_field.expect :valid?, true
    @field.set 20
    assert @field.valid?
  end

  def test_convert_float_string
    @field.set '5.24'
    assert_equal 524, @field.convert
  end

  def test_convert_integer_string
    @field.set '124'
    assert_equal 124, @field.convert
  end

  def test_convert_float
    @field.set 1.23
    assert_equal 123, @field.convert
  end

  def test_convert_integer
    @field.set 234
    assert_equal 234, @field.convert
  end

  def test_convert_object_with_to_i_method
    value = MiniTest::Mock.new
    value.expect :is_a?, false, [String]
    value.expect :is_a?, false, [Float]
    value.expect :to_i, 345
    @field.set value
    assert_equal 345, @field.convert
  end
end
