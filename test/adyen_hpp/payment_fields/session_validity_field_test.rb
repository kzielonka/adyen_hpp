require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsSessionValidityFieldTest < Minitest::Test
  class ObjectWithToTimeMethod
    def initialize time
      @time = time
    end

    def to_time
      @time
    end
  end

  def setup
    @class = AdyenHpp::PaymentFields::SessionValidityField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'session_validity', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'sessionValidity', @class.adyen_field_name
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

  def test_object_with_to_time_method
    time = Time.new(2015, 1, 2, 3, 4, 5, 3 * 3600)
    @field.set ObjectWithToTimeMethod.new(time)
    assert_equal '2015-01-02T03:04:05+03:00', @field.convert
  end
end
