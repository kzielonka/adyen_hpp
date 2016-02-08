require 'minitest/autorun'
require 'adyen_hpp'
require 'object_without_to_s'


class AdyenHppPaymentFieldsMerchantSigFieldTest < Minitest::Test

  def setup
    @class = AdyenHpp::PaymentFields::MerchantSigField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'merchant_sig', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'merchantSig', @class.adyen_field_name
  end

  def test_valid_when_value_is_nil
    @field.set nil
    refute @field.valid?
  end

  def test_invalid_when_value_has_not_to_s_method
    @field.set ObjectWithoutToS.new
    refute @field.valid?
  end

  def test_valid_for_string
    @field.set 'sample string'
    assert @field.valid?
  end

  def test_convert_object_without_to_s_method
    @field.set ObjectWithoutToS.new
    assert_raises TypeError do
      @field.convert
    end
  end

  def test_convert_string
    @field.set 'sample data'
    assert_instance_of String, @field.convert
  end
end
