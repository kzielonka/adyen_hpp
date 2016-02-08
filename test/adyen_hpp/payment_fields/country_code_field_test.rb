require 'minitest/autorun'
require 'adyen_hpp'
require 'object_without_to_s'

class AdyenHppPaymentFildsCountryCodeFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::CountryCodeField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'country_code', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'countryCode', @class.adyen_field_name
  end

  def test_valid_when_value_is_nil
    @field.set nil
    assert @field.valid?
  end

  def test_invalid_when_value_has_not_to_s_method
    @field.set ObjectWithoutToS.new
    refute @field.valid?
  end

  def test_invalid_with_too_long_string
    @field.set 'xxx'
    refute @field.valid?
  end

  def test_valid_with_value_en
    @field.set 'en'
    assert @field.valid?
  end

  def test_valid_with_symbol_pl
    @field.set :pl
    assert @field.valid?
  end

  def test_convert_object_without_to_s_method
    @field.set ObjectWithoutToS.new
    assert_raises TypeError do
      @field.convert
    end
  end

  def test_convert_string
    @field.set 'pl'
    assert_equal 'PL', @field.convert
  end

  def test_convert_symbol
    @field.set :en
    assert_equal 'EN', @field.convert
  end

  def test_converted_string_is_frozzen
    @field.set :it
    assert @field.convert.frozen?
  end
end
