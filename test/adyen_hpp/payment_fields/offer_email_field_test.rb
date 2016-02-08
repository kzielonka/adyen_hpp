require 'minitest/autorun'
require 'adyen_hpp'
require 'string_fields_shared_tests'

class AdyenHppPaymentFieldsOfferEmailFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::OfferEmailField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'offer_email', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'offerEmail', @class.adyen_field_name
  end

  include StringFieldsSharedTests
end
