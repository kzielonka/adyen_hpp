require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsMerchantAccountFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::MerchantAccountField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'merchant_account', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'merchantAccount', @class.adyen_field_name
  end

  def test_validation_when_nil
    @field.set nil
    refute @field.valid?
  end

  def test_validation_when_valid_string
    @field.set 'MerchantAccount'
    assert @field.valid?
  end

  def test_invalid_when_no_string
    @field.set Object.new
    refute @field.valid?
  end

  def test_convert_string
    @field.set 'string'
    assert 'string', @field.convert
  end

  def test_convert_raises_error
    @field.set Object.new
    assert_raises TypeError do
      @field.convert
    end
  end
end
