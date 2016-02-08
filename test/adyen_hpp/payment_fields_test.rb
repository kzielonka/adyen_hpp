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
    shopperLocale shopperReference shopperStatement skinCode
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
    shopper_locale shopper_reference shopper_statement skin_code
  ).each do |field_name|
    define_method "test_field_#{field_name}_is_defined" do
      assert AdyenHpp::PaymentFields.has_field?(field_name)
    end

    define_method "test_respond_to_#{field_name}" do
      assert @payment_fields.respond_to?(field_name)
    end

    define_method "test_respond_to_#{field_name}=" do
      assert @payment_fields.respond_to?("#{field_name}=")
    end
  end

  def test_respond_to_returns_false
    refute @payment_fields.respond_to? :invalid_method_name
  end

  def test_respond_to_each
    assert @payment_fields.respond_to? :each
  end

  def test_field_undefinedField_is_not_defined
    refute AdyenHpp::PaymentFields.has_adyen_field? 'undefinedField'
  end

  def test_field_undefined_field_is_not_defined
    refute AdyenHpp::PaymentFields.has_field? 'undefined_field'
  end

  def test_initialization
    payment_fields = AdyenHpp::PaymentFields.new(
      payment_amount: 50,
      skin_code: 'code'
    )
    assert_equal 50, payment_fields[:payment_amount].convert
    assert_equal 'code', payment_fields[:skin_code].convert
    assert_equal nil, payment_fields[:issuer_id].convert
  end

  def test_error_rasing_on_setting_undefined_field
    assert_raises ArgumentError do
      @payment_fields[:undefined_field] = 5
    end
  end
end
