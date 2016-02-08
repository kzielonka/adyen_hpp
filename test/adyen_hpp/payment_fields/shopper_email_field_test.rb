require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsShopperEmailFieldTest < Minitest::Test
  class ValidObject
    def to_str
      'some string'
    end
  end

  def setup
    @class = AdyenHpp::PaymentFields::ShopperEmailField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'shopper_email', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'shopperEmail', @class.adyen_field_name
  end

  def test_valid_when_nil
    @field.set nil
    assert @field.valid?
  end

  def test_invalid_when_without_to_str_method
    @field.set Object.new
    refute @field.valid?
  end

  def test_valid_when_string
    @field.set 'string'
    assert @field.valid?
  end

  def test_convert_string
    @field.set '1234'
    assert_equal '1234', @field.convert
  end

  def test_convert_object_with_to_str
    object = ValidObject.new
    @field.set object
    assert_equal object.to_str, @field.convert
  end

  def test_convert_raises_error
    @field.set Object.new
    assert_raises TypeError do
      @field.convert
    end
  end
end
