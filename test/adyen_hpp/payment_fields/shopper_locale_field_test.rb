require 'minitest/autorun'
require 'adyen_hpp'
require 'object_without_to_s'

class AdyenHppPaymentFieldsShopperLocaleField < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::ShopperLocaleField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'shopper_locale', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'shopperLocale', @class.adyen_field_name
  end

  def test_validation_when_nil
    @field.set nil
    assert @field.valid?
  end

  def test_invalid_when_can_not_be_convert_value_to_string
    @field.set ObjectWithoutToS.new
    refute @field.valid?
  end

  def test_invalid_when_value_has_wrong_format
    @field.set '5#$%$#'
    refute @field.valid?
  end

  def test_valid_when_value_is_en
    @field.set 'en'
    assert @field.valid?
  end

  def test_valid_when_valie_en_us
    @field.set 'en_US'
    assert @field.valid?
  end

  def test_convert_raises_error
    @field.set ObjectWithoutToS.new
    assert_raises TypeError do
      @field.convert
    end
  end

  def test_convert_symbol
    @field.set :en
    assert_equal 'en', @field.convert
  end

  def test_convert_string
    @field.set 'pl_PL'
    assert_equal 'pl_PL', @field.convert
  end
end
