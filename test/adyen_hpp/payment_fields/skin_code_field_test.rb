require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsSkinCodeFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::SkinCodeField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'skin_code', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'skinCode', @class.adyen_field_name
  end

  def test_validation_when_nil
    @field.set nil
    refute @field.valid?
  end

  def test_validation_when_valid_string
    @field.set 'x523fw4gR'
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
