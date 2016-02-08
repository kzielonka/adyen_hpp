require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsAllowedMethodsFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::AllowedMethodsField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'allowed_methods', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'allowedMethods', @class.adyen_field_name
  end

  def test_valid_when_value_is_nil
    @field.set nil
    assert @field.valid?
  end

  def test_invalid_when_object_can_not_be_converted
    @field.set Object.new
    refute @field.valid?
  end

  def test_valid_for_string
    @field.set 'sample_string'
    assert @field.valid?
  end

  def test_valid_for_array
    @field.set ['method1', 'method2']
    assert @field.valid?
  end

  def test_valid_for_array_with_string_and_symbol
    @field.set ['method1', :method2]
    assert @field.valid?
  end

  def test_invalid_for_array_with_invalid_object
    @field.set ['method1', Object.new]
    refute @field.valid?
  end

  def test_convert_string
    @field.set 'method1,method2'
    assert_equal 'method1,method2', @field.convert
  end

  def test_convert_array_of_strings
    @field.set ['m1', 'm2']
    assert_equal 'm1,m2', @field.convert
  end

  def test_convert_arrray_of_symbols
    @field.set [:sym1, :sym2]
    assert_equal 'sym1,sym2', @field.convert
  end

  def test_convert_raises_error_for_invalid_input
    @field.set Object.new
    assert_raises TypeError do
      @field.convert
    end
  end

  def test_convert_raises_error_for_invalid_array
    @field.set ['test', Object.new]
    assert_raises TypeError do
      @field.convert
    end
  end
end
