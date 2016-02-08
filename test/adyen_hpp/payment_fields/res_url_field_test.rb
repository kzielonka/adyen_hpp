require 'minitest/autorun'
require 'adyen_hpp'
require 'string_fields_shared_tests'

class AdyenHppPaymentFieldsResUrlFieldTest < Minitest::Test
  def setup
    @class = AdyenHpp::PaymentFields::ResUrlField
    @field = @class.new
  end

  def test_field_name
    assert_equal 'res_url', @class.field_name
  end

  def test_adyen_field_name
    assert_equal 'resURL', @class.adyen_field_name
  end

  include StringFieldsSharedTests
end
