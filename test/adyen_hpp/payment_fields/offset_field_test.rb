require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsOffsetFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::OffsetField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'offset', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'offset', @class.adyen_field_name
  end

  def test_valid_when_value_is_nil
    @field.set nil
    assert @field.valid?
  end

  def test_invalid_when_object_can_not_be_converted
    @field.set Object.new
    refute @field.valid?
  end

  def test_valid_for_integer_string
    @field.set '123'
    assert @field.valid?
  end

  def test_invalid_for_invalid_string
    @field.set 'invalid string'
    refute @field.valid?
  end

  def test_valid_for_integer
    @field.set 123
    assert @field.valid?
  end

  def test_convert_string
    @field.set '5234'
    assert_equal 5234, @field.convert
  end

  def test_convert_float
    @field.set 5.2
    assert_equal 5, @field.convert
  end

  def test_convert_raises_error_for_invalid_input
    @field.set Object.new
    assert_raises TypeError do
      @field.convert
    end
  end
end
