require 'minitest/autorun'
require 'adyen_hpp'
require 'string_fields_shared_tests'

class AdyenHppPaymentFieldsBrandCodeFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::BrandCodeField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'brand_code', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'brandCode', @class.adyen_field_name
  end

  include StringFieldsSharedTests
end
