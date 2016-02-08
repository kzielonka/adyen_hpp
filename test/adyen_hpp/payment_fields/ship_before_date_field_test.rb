require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsShipBeforeDateFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::ShipBeforeDateField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'ship_before_date', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'shipBeforeDate', @class.adyen_field_name
  end

  def test_validation_when_nil
    @field.set nil
    refute @field.valid?
  end

  def test_validation_when_invalid_string
    @field.set 'invalid string'
    refute @field.valid?
  end

  def test_validation_when_valid_string
    @field.set '2015-11-29T13:42:40+01:00'
    assert @field.valid?
  end

  def test_validation_with_time_object
    @field.set Time.now
    assert @field.valid?
  end

  def test_convert_invalid_type
    @field.set Object.new
    assert_raises TypeError do
      @field.convert
    end
  end

  def test_convert_time
    @field.set Time.new(2016, 3, 8, 2, 43, 21, -5 * 3600)
    assert_equal '2016-03-08T02:43:21-05:00', @field.convert
  end

  def test_convert_valid_string
    @field.set '2015-12-30T10:04:01+02:00'
    assert_equal '2015-12-30T10:04:01+02:00', @field.convert
  end
end
