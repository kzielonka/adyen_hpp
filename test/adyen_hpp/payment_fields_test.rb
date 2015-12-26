require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppPaymentFieldsTest < Minitest::Test
  def setup
    @payment_fields = AdyenHpp::PaymentFields.new
  end

  def test_respond_to_has_field
    assert_respond_to AdyenHpp::PaymentFields, :has_field?
  end

  def test_respond_to_has_adyeb_field
    assert_respond_to AdyenHpp::PaymentFields, :has_adyen_field?
  end

  %w(
    allowedMethods blockedMethods brandCode countryCode
    currencyCode issuerId merchantAccount merchantReference
    merchantReturnData merchantSig offerEmail offset orderData
    paymentAmount resURL sessionValidity shipBeforeDate
    shopperLocale shopperReferrence shopperStatement skinCode
  ).each do |field_name|
    define_method "test_adyen_field_#{field_name}_is_defined" do
      assert AdyenHpp::PaymentFields.has_adyen_field? field_name
    end
  end

  %w(
    allowed_methods blocked_methods brand_code country_code
    currency_code issuer_id merchant_account merchant_reference
    merchant_return_data merchant_sig offer_email offset order_data
    payment_amount res_url session_validity ship_before_date
    shopper_locale shopper_referrence shopper_statement skin_code
  ).each do |field_name|
    define_method "test_field_#{field_name}_is_defined" do
      assert AdyenHpp::PaymentFields.has_field? field_name
    end
  end

  def test_field_undefinedField_is_not_defined
    refute AdyenHpp::PaymentFields.has_adyen_field? 'undefinedField'
  end

  def test_field_undefined_field_is_not_defined
    refute AdyenHpp::PaymentFields.has_field? 'undefined_field'
  end

  def test_initialization
    payment_fields = AdyenHpp::PaymentFields.new({
      payment_amount: 50,
      skin_code: 'code'
    })
    assert_equal 50, payment_fields[:payment_amount]
    assert_equal 'code', payment_fields[:skin_code]
    assert_equal nil, payment_fields[:issuer_id]
  end
  
  def test_error_rasing_on_setting_undefined_field
    assert_raises ArgumentError do
      @payment_fields[:undefined_field] = 5
    end
  end
end
