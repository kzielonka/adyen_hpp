require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsCurrencyCodeFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::CurrencyCodeField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'currency_code', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'currencyCode', @class.adyen_field_name
  end

  def test_converting_string
    @field.set 'usd'
    assert_equal 'USD', @field.convert
  end

  def test_converting_sumbol
    @field.set :Eur
    assert_equal 'EUR', @field.convert
  end

  def test_validation_missing_value
    @field.set nil
    refute @field.valid?
  end

  def test_validation_not_existing_code
    AdyenHpp::Dependencies.instance.currencies.stub :exists?, false do
      @field.set 'not existing code'
      refute @field.valid?
    end
  end

  def test_validation_for_valid_value
    AdyenHpp::Dependencies.instance.currencies.stub :exists?, true do
      @field.set 'eur'
      assert @field.valid?
    end
  end
end
